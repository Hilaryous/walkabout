require 'rails_helper'

describe 'displaying a walk' do
  before(:each) do
    @start_location = create(:start_location)
    @finish_location = create(:finish_location)
    @location  = create(:location)
    @sight = create(:sight, location: @location)
    @walk = create(:walk, start_location: @start_location, finish_location: @finish_location)
    WalkLocation.create(walk_id: @walk.id, location_id: @location.id )
    visit walk_path(@walk)
  end

  it "shouldn't fail" do
    expect(page.status_code).to eq 200
  end

  it 'should have the name of the walk' do
    expect(page).to have_content("Test Walk")
  end

  it 'should have the start point of the walk' do
    expect(page).to have_content(@start_location.address)
  end

  it 'should have the end point of the walk' do
    # expect(page).to have_content(@finish_location.address)
  end

  it 'should have a start point and an end point that are the same by default' do
    # expect(find(:css, "div.finish_location").text).to eq(find(:css, "div.finish_location").text)
  end

  context 'one sight location' do
    xit 'should have the sight location' do
      expect(page).to have_content(@location.address)
      expect(page).to have_content(@sight.name)
    end

    it 'should have the directions from start to sight to end location' do
      # expect(page).to have_content("left onto Welton St") javascript
    end
  end

  context 'two sight locations' do
    before(:each) do
      @location_2 = Location.create(street: "1445 Larimer St", city: "Denver", state: "CO")
      @sight_2 = Sight.create(name:"Gallup-Stanbury Building", kind: "historic landmark", location: @location_2)
      WalkLocation.create(walk_id: @walk.id, location_id: @location_2.id)
      visit walk_path(@walk)
    end

    xit 'should have the sight locations' do
      expect(page).to have_content("1445 Larimer St")
    end

    xit 'should have the directions from start to sight to sight to end location' do
      expect(page).to have_content("left toward Grant St")
    end
  end
end
