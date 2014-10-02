FactoryGirl.define do
  factory :location do
    latitude 39.74745784
    longitude -104.95018343
  end

  factory :start_location do
    street "1500 Blake Street"
    city "Denver"
    state "CO"
    zipcode "80202"
    latitude 39.74946800000001
    longitude -105.0000485
  end
end
