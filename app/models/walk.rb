class Walk < ActiveRecord::Base
  has_many :walk_locations
  has_many :locations, through: :walk_locations
  has_one  :start_location
  has_one  :finish_location

  validates :distance, presence: true

  def waypoints
    locations.to_json(:only => [:latitude, :longitude])
  end

  def total_distance
    distances = locations.map do |location|
      location.distance_from([start_location.latitude, start_location.longitude])
    end
    distances.reduce(:+)
  end

  def assign_locations
    locations << start_location.closest_location_to_start
    while total_distance < distance
      locations << locations.last.closest_location_to_start
    end
  end
end
