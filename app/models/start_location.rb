class StartLocation < Location
  belongs_to :walk

  def locations_within_walk_distance_circumfrance
    Location.near([latitude, longitude], walk.distance)
  end

  def locations
    locations_within_walk_distance_circumfrance.where(type: nil)
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
