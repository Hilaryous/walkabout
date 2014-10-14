class CreateSightsTable < ActiveRecord::Migration
  def change
    create_table :sights do |t|
      t.string :name
      t.string :kind
      t.string :established_date
      t.string :direct_upload_url
    end
  end
end
