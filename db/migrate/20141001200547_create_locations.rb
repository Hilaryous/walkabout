class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.integer :sight_id
      t.integer :walk_id
      t.string :type
    end
  end
end
