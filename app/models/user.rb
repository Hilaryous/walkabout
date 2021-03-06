class User < ActiveRecord::Base
  has_many :walks
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.save!
    end
  end

  def total_locations
    walks.inject(0) { |sum, walk| sum += walk.locations.count }
  end

  def total_distance
    walks.inject(0) { |sum, walk| sum += walk.distance }
  end
end
