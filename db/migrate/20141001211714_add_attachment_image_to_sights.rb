class AddAttachmentImageToSights < ActiveRecord::Migration
  def self.up
    change_table :sights do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :sights, :image
  end
end
