class Location < ActiveRecord::Base
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
  after_validation :geocode, :reverse_geocode

  def address
    [street, city, state].join(", ")
  end
end
