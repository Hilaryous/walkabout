class StartLocation < Location
  belongs_to :walk

  def locations_within_walk_distance_circumfrance
    Location.near([latitude, longitude], walk.distance) - Location.near([latitude, longitude], (walk.distance)/2)
  end

  def locations
    #locations_within_walk_distance_circumfrance.where(type: nil)
    Location.near([latitude, longitude], walk.distance/(2*Math::PI)).where(type: nil) -
    Location.near([latitude, longitude], (walk.distance/(2*Math::PI))/1.5).where(type: nil)
  end

  def distance_from_start
    distance_hash = Hash.new
    locations.map do |location|
      distance = walk.start_location.distance_from([location.latitude, location.longitude])
      distance_hash[location] = distance
    end
    distance_hash
  end

  def closest_location_to_start
    location = distance_from_start.min_by{|k,v| v}.first
  end
end


# first_set = [location_1, location_2, ... location_8] # => google = response_1
# second_set = [location_8, location_9, ...] # => google = response_2

# frontend //
# stitch together response_1, 2
