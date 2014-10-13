require 'rails_helper'

RSpec.describe Location, type: :model  do

  let(:start_location) do
    create(:start_location)
  end

  it 'is valid' do
    expect(start_location).to be_valid
  end

  it 'geocodes lat and long to address' do
    expect(start_location.street).to eq "2301-2399 Welton Street"
  end

  it 'reverse geocodes address to lat and long' do
    expect(start_location.latitude).to eq 39.75185879
    expect(start_location.longitude).to eq -104.98268713
  end

  xit 'finds all locations within the radius of the walk distance' do
    expect(start_location.locations_within_walk_distance_circumfrance.count).to eq
  end

  xit 'finds locations that are not already in the walk and are not start' do
    start_location.locations
  end

  xit 'finds the distance of all locations from start' do
  end

  xit 'finds the closest location to start' do
  end
end
