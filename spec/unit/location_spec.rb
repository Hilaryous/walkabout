require 'rails_helper'

RSpec.describe Location, type: :model  do

	let(:location) do
		create(:location)
	end

  it 'is valid' do
    expect(location).to be_valid
  end

  it 'combines attributes into address' do
    expect(location.address).to eq("#{location.street}, #{location.city}, #{location.state}")
  end
end
