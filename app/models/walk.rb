class Walk < ActiveRecord::Base
  has_many :walk_locations
  has_many :locations, through: :walk_locations

  validates :distance, presence: true

  def start_point
    locations.find_by(loc_type: 1).address
  end

  def end_point
    locations.find_by(loc_type: 2)
  end
end
