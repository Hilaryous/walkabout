require 'rails_helper'

RSpec.describe Location, type: :model  do

	let(:location) do
		create(:location)
	end

  it 'is valid' do
    expect(location).to be_valid
  end

	it 'geocodes lat and long to address' do
		expect(location.street).to eq "2301-2399 Welton Street"
	end

	it 'reverse geocodes address to lat and long' do
		expect(location.latitude).to eq 39.75185879
		expect(location.longitude).to eq -104.98268713
	end

  it 'combines attributes into address' do
    expect(location.address).to eq("#{location.street}, #{location.city}, #{location.state}")
  end

	xit 'finds all locations within the radius of the walk distance' do
		expect(location.locations_within_walk_distance_circumfrance.count).to eq
	end

	xit 'finds locations that are not already in the walk and are not start' do
		location.locations
	end

	xit 'finds the distance of all locations from start' do
	end

	xit 'finds the closest location to start' do
	end
end
