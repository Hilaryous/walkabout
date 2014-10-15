class Sight < ActiveRecord::Base
  has_one :location
  has_attached_file :image,
  :styles => { :medium => "300x300#", :thumb => "100x100#" },
  :default_url => "http://blog.wsd.net/mthorngren/files/2011/05/Denver-1.jpg",
  :storage => :s3,
              :s3_credentials => "#{Rails.root}/config//aws.yml",
              :path => ":class/:attachment/:id/:style/:filename",
              :url => ':s3_domain_url'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.sight_kinds
    all.where.not(kind: nil).pluck(:kind).uniq
  end

  def self.sights_by_kind
    all.group_by(&:kind)
  end
end
