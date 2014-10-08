class CreateWalk < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.string :name
      t.float :distance
    end
  end
end
