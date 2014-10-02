class CreateWalkLocations < ActiveRecord::Migration
  def change
    create_table :walk_locations do |t|
      t.integer :walk_id
      t.integer :location_id
    end
  end
end
