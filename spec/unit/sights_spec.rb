require 'rails_helper'

RSpec.describe Sight, type: :model  do

  let(:sight) do
    create(:sight)
  end

  it 'is valid' do
    expect(sight).to be_valid
  end

  xit 'has a location' do
  end
end
