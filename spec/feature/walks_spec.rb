require 'rails_helper'

describe 'walk' do
  context 'create' do
    before(:each) do
      @location  = create(:location)
      @sight = create(:sight, :location => @location)
      visit new_walk_path
    end

    it "shouldn't fail" do
      expect(page.status_code).to eq 200
    end

    it 'should have an option to name the walk' do
      find_field("Name")
    end

    xit 'should have a place to insert the distance' do
      find_field("Distance")
    end

    xit 'should have defualt sights which are all the sights within the distance radius of start location' do
      #not sure how to test this yet
    end

    xit 'should have a place to choose the sights' do
      find_field("Sights")
    end

    xit 'should have a place to choose a type of sight(has many loactions included)' do
      find_field("Type")
    end

    xit 'should have a place to enter start point' do
      find_field("Start Point")
    end

    xit 'should set start point to ip address by default' do
      expect(find_field("Start Point").value).to eq "the ip address"
    end

    xit 'can create a walk' do
      fill_in "walk[name]", with: "Test Walk"
      fill_in "walk[distance]", with: 5
      click_button("Take A Walk")
      expect(path).to be(walks_path(walk))
    end

    xit 'cannot create a walk without a distance' do
      fill_in "walk[name]", with: "Test Walk"
      click_button("Take A Walk")
      expect(path).not_to be(walks_path(walk))
      expect(page).to have content 'blank'
    end

    context 'after a walk is created' do
      xit 'is directed to the walk show page' do
        fill_in "walk[name]", with: "Test Walk"
        fill_in "walk[distance]", with: 5
        click_button("Take A Walk")
        expect(path).to be(walks_path(walk))
      end

      xit 'has the walk that was just created on the show page' do
        fill_in "walk[name]", with: "Test Walk"
        fill_in "walk[distance]", with: 5
        click_button("Take A Walk")
        expect(page).to have_content("5 miles")
      end
    end
  end

  context 'show' do
    before(:each) do
      @start_locaton = create(:start_location)
      @location  = create(:location)
      @sight = create(:sight, :location => @location)
      @walk = create(:walk, :sight => @sight)
      visit walks_path(@walk)
    end

    xit "shouldn't fail" do
      expect(page.status_code).to eq 200
    end

    xit 'should have the name of the walk' do
      expect(page).to have_content("Test Walk")
    end

    xit 'should have the start point of the walk' do
      expect(page).to have_content(@walk.start_location.address)
    end

    xit 'should have the end point of the walk' do
      expect(page).to have_content(@walk.end_location.address)
    end

    xit 'should have a start point and an end point that are the same' do
      expect(@walk.end_location.address).to eq(@walk.start_location.address)
    end

    xit 'should have the sight location(s)' do
      expect(page).to have_content(@walk.sight.location)
      #want it to have the location of the site
      #starting out with just one sight will move towards multiple sites
    end

    xit 'should have the directions from start to sight to end locations' do
      #not sure what this looks like yet
    end
  end
end
