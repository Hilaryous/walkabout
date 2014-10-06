class StartLocation < Location
  belongs_to :walk

  def nearest_locations
    Location.near([latitude, longitude], walk.distance)
  end
end
