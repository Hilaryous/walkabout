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

  def locations_within_walk_distance_bubble
    Location.near([latitude, longitude], walk.distance)
  end

  def non_start_locations
    locations_within_walk_distance_bubble.where(type: nil)
  end

  def distance_from_start
    distance_hash = Hash.new
    non_start_locations.map do |location|
      distance = walk.start_location.distance_from([location.latitude, location.longitude])
      distance_hash[location] = distance
    end
    distance_hash
  end

  def distance_from_non_start_locations
    distance_hash = Hash.new
    non_start_locations.map.with_index do |location, index|
      distance = walk.locations.distance_from([location.latitude, location.longitude])
      distance_hash[location] = distance
    end
    distance_hash
  end

  def closest_location_to_start
    location = distance_from_start.min_by{|k,v| v}.first
  end

  def closest_location
    location = distance_from_non_start_locations.min_by{|k,v| v}.first
  end
end
