require 'rails_helper'

RSpec.describe Walk, type: :model  do

  let(:walk) do
    create(:walk)
  end

  it 'is valid' do
    expect(walk).to be_valid
  end

  xit 'has a distance' do
  end

  xit 'has a total distance of all locations' do
  end

  xit 'can assign the closest location to itself' do
  end
end
