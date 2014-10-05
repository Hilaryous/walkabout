class FinishLocation < Location
  belongs_to :walk

  def nearest_locations
    if walk.locations.count == 0
      Location.near([latitude, longitude], 0)
    else
      Location.near([latitude, longitude], walk.distance / (walk.locations.count * 2))
    end
  end
end
