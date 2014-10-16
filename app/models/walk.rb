class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :walk_locations
  has_many :locations, through: :walk_locations
  has_one  :start_location
  has_one  :finish_location

  validates :distance, presence: true

  def waypoints
    locations.limit(8).to_json(:only => [:latitude, :longitude])
  end

  def google_locations
    locations.limit(8)
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
      # locations << locations.last.nearest_other_point
    end
  end

  def locations_with_sight_names
    self.google_locations.map do |location|
      "#{location.sight.name}, #{location.address}"
    end
  end
end
