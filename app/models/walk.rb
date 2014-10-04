class Walk < ActiveRecord::Base
  has_many :walk_locations
  has_many :locations, through: :walk_locations
  has_one  :start_location
  has_one  :finish_location

  validates :distance, presence: true
end
