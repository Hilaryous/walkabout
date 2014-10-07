class Walk < ActiveRecord::Base
  has_many :walk_locations
  has_many :locations, through: :walk_locations
  has_one  :start_location
  has_one  :finish_location

  validates :distance, presence: true

  def total_distance
    locations.reduce(0) do |sum, location|
      sum + location.distance
    end
  end

  def assign_locations
    locations << start_location.closest_location_to_start
    until total_distance == distance
      locations << locations[0].closest_location
    end
  end
end
