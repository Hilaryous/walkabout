class WalkSerializer < ActiveModel::Serializer
  attributes :id, :name, :distance
  has_one :start_location
  has_many :locations

  def distance
    "#{object.distance} + mi"
  end
end
