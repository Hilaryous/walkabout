class CreateSightsTable < ActiveRecord::Migration
  def change
    create_table :sights do |t|
      t.string :name
      t.string :kind
      t.string :established_date
    end
  end
end
