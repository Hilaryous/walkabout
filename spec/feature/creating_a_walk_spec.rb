require 'rails_helper'

describe 'creating a walk' do
  before(:each) do
    @location  = create(:location)
    @location_2 = Location.create(street: "144 West Colfax Avenue", city: "Denver", state: "CO")
    @sight = create(:sight, :location => @location)
    visit new_walk_path
  end

  it "should pass" do
    expect(page.status_code).to eq 200
  end

  it 'should have an option to name the walk' do
    find_field("Name")
  end

  it 'should have a place to insert the distance' do
    find_field("Distance")
  end

  it 'should have a place to enter start point' do
    find_field("Start Point")
  end

  it 'can create a walk' do
    fill_in "walk[name]", with: "Test Walk"
    fill_in "walk[distance]", with: 1
    click_button("Take A Walk")
  end

  it 'cannot create a walk without a distance' do
    fill_in "walk[name]", with: "Test Walk"
    click_button("Take A Walk")
    expect(page).to have_content 'blank'
  end

  context 'customized start and end points' do
    it 'can create a walk without a start point' do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      fill_in "walk[finish_location]", with: "39.7494680, -105.0000480"
      click_button("Take A Walk")
    end

    it 'can create a walk without an end point' do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      fill_in "walk[start_location]", with: "39.7494680, -105.0000480"
      click_button("Take A Walk")
    end

    it 'can create a walk without a start nor an end point' do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      click_button("Take A Walk")
    end

    it 'will have a start and an end point of current location by default', js: true do
      Capybara.default_wait_time = 5
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      click_button("Take A Walk")
      within first(".street-address") do
        expect(page).to have_content "200 E Colfax Avenue,"
      end

      within all(".street-address").last do
        expect(page).to have_content "200 E Colfax Avenue"
      end
    end

    it 'will have an end location that is the same as the start location by defualt', :js => true do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      click_button("Take A Walk")
      expect(first(".street-address").text).to eq(all(".street-address").last.text)
    end

    it 'can create a walk with a different start point and end point', :js => true do
      fill_in "walk[distance]", with: 1
      fill_in "walk[start_location]", with: "39.7494680, -105.0000480"
      fill_in "walk[finish_location]", with: "39.7494680, -104.0000480"
      click_button("Take A Walk")
      within first(".street-address") do
        expect(page).to have_content "1469 15th Street,"
        expect(page).to_not have_content "Hanks Crossing Road,"
      end
      within all(".street-address").last do
        expect(page).to have_content "Hanks Crossing Road,"
        expect(page).to_not have_content "1469 15th Street,"
      end
    end

    xit 'cannot create a walk if the difference between start and end locations are more than the distance', :js => true do
#################figure out how to do... ?????##########################
      fill_in "walk[distance]", with: 1
      fill_in "walk[start_location]", with: "39.7494680, -105.0000480"
      fill_in "walk[finish_location]", with: "39.7494680, -104.0000480"
      click_button("Take A Walk")
      expect(page).to have_content("cannot be greater")
    end
  end

  context 'after a walk with custom start and end points is created' do
    it 'has the walk that was just created on the show page', :js => true do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 1
      click_button("Take A Walk")
      expect(page).to have_content("1 mi")

      within first(".street-address") do
        expect(page).to have_content "200 E Colfax Avenue"
      end
    end
  end

  context 'cutomized sights' do
    xit 'should have option to customize my walk' do
    end

    xit 'should have default sights which are all the sights within the distance radius of start location' do
      #not sure how to test this yet
    end

    xit 'should have a place to choose the sights' do
      find_field("Sights")
    end

    xit 'should have a place to choose a type of sight(has many loactions included)' do
      find_field("Type")
    end
  end
end
