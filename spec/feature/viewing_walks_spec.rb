require 'rails_helper'

describe 'walks' do
  before(:each) do
    @start_location = create(:start_location)
    @finish_location = create(:finish_location)
    @location  = create(:location)
    @sight = create(:sight, location: @location)
    @location_2 = Location.create(street: "1445 Larimer St", city: "Denver", state: "CO")
    @sight_2 = Sight.create(name:"Gallup-Stanbury Building", kind: "historic landmark", location: @location_2)
    @user = User.create(id: 1, provider: "google_oauth2", uid: "12345", name: "Example User", email: "Example User", created_at: "2014-10-12 21:42:53", updated_at: "2014-10-12 21:42:53")
    @walk = create(:walk, start_location: @start_location, finish_location: @finish_location, user: @user)
    WalkLocation.create(walk_id: @walk.id, location_id: @location_2.id)
    WalkLocation.create(walk_id: @walk.id, location_id: @location.id )
    login_with_oauth
    visit walks_path
  end

  it 'shows the name' do
    expect(page).to have_content @walk.name
  end

  it 'shows the distance' do
    expect(page).to have_content @walk.distance
  end

  it 'shows to start location' do
    expect(page).to have_content @walk.start_location.address
  end

  it 'shows the user total walks' do
    expect(page).to have_content @user.walks.count
  end

  it 'shows the user total locations' do
    expect(page).to have_content @user.total_locations
  end

  it 'shows the user total distance' do
    expect(page).to have_content @user.total_distance
  end
end
