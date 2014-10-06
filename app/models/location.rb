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
end
