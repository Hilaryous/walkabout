class CreateWalk < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.string :name
      t.float :distance
      t.integer :user_id
    end
  end
end
