class Sight < ActiveRecord::Base
  acts_as_copy_target
  has_one :location
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://blog.wsd.net/mthorngren/files/2011/05/Denver-1.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
