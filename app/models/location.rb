class Location < ActiveRecord::Base
  belongs_to :sight
  has_many :walk_locations
  has_many :walks, through: :walk_locations

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.street  = geo.street_address
      obj.city    = geo.city
      obj.state   = geo.state
      obj.zipcode = geo.postal_code
      obj.country = geo.country_code
    end
  end

  before_validation :geocode, :if => lambda{ |obj| obj.address_changed? }
  before_validation :reverse_geocode

  def address
    [street, city, state].join(", ")
  end

  def address_changed?
    attrs = %w(street city state)
    attrs.any?{|a| send "#{a}_changed?"}
  end

  def locations_within_walk_distance_circumfrance
    Location.near([latitude, longitude], StartLocation.last.walk.distance)
  end

  def locations
    current_walk_locations = StartLocation.last.walk.locations.map do |location|
      location.id
    end
    locations_within_walk_distance_circumfrance.where(type: nil).where.not(id: [current_walk_locations])
  end

  def distance_from_start
    distance_hash = Hash.new
    locations.map.with_index do |location, index|
      distance = StartLocation.last.walk.locations.last.distance_from([location.latitude, location.longitude])
      distance_hash[location] = distance
    end
    distance_hash
  end

  def closest_location_to_start
    location = distance_from_start.min_by{|k,v| v}.first
  end
end
