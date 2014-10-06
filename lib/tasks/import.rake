require 'csv'

desc "Import sights and locations from park csv file"
task :import => [:environment] do

  park_file = "db/data-walkabout/parks.csv"
  public_art_file = "db/data-walkabout/public_art.csv"
  park_fountain_file = "db/data-walkabout/park_fountains.csv"
  historic_landmark_file = "db/data-walkabout/historic_landmarks.csv"
  downtown_historic_district_file = "db/data-walkabout/downtown_denver_historic_district.csv"

  CSV.foreach(park_file, :headers => true) do |row|
    Sight.create({
      :name => row[1],
      :kind => row[3],
      :established_date => row[7]
    })

    Location.create({
      :latitude => row[19],
      :longitude => row[20],
      :sight_id => Sight.last.id
      })
  end
  puts "park file imported"

  CSV.foreach(public_art_file, :headers => true) do |row|
    Sight.create({
      :name => row[2],
      :kind => row[4],
      :established_date => row[1]
    })

    Location.create({
      :street => row[5],
      :city => "Denver",
      :state => "CO",
      :sight_id => Sight.last.id
      })
  end
  puts "public art file imported"

  CSV.foreach(park_fountain_file, :headers => true) do |row|
    Sight.create({
      :name => row[3],
      :kind => row[0]
    })

    Location.create({
      :street => row[1],
      :city => "Denver",
      :state => "CO",
      :sight_id => Sight.last.id
      })
  end
  puts "park fountain file imported"

  CSV.foreach(historic_landmark_file, :headers => true) do |row|
    Sight.create({
      :name => row[1],
      :kind => "historic landmark"
    })

    Location.create({
      :street => row[5],
      :city => row[8],
      :state => "CO",
      :zipcode => row[10],
      :sight_id => Sight.last.id
      })
  end
  puts "historic landmark file imported"

  CSV.foreach(downtown_historic_district_file, :headers => true) do |row|
    Sight.create({
      :name => row[1],
      :kind => "historic landmark"
    })

    Location.create({
      :street => row[2],
      :city => "Denver",
      :state => "CO",
      :sight_id => Sight.last.id
      })
  end

  puts "downtown historic district file imported"
  @locations = Location.where(street: "1340 Sherman Street")
  @locations.each do |location|
    if location.sight
      location.sight.destroy
    end
  end
  Location.destroy_all(street: "1340 Sherman Street")
end
