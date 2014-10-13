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

  it "should pass" do
    expect(page.status_code).to eq 200
  end

  it 'should have the start point of the walk' do
    expect(page).to have_content(@start_location.address)
  end

  it 'should have the end point of the walk' do
    expect(page).to have_content(@finish_location.address)
  end

  it 'should have a start point and an end point that are the same by default' do
    expect(all(".street-address").last.text).to eq(first(".street-address").text)
  end

  context 'one sight location' do
    it 'should have the location', :js => true do
      expect(page).to have_content("Welton")
    end

    it 'should have the directions from start to sight to end location', :js => true do
      within ('#leg-0') do
        within ("#step-0") do
          expect(first(".text").text).to eq("Head southeast on 15th St toward Market St")
        end
        within ("#step-1") do
          expect(first(".text").text).to include("Destination will be on")
        end
      end
      within ('#leg-1') do
        within ("#step-1") do
          expect(first(".text").text).to include("right onto 15th")
        end
      end
    end

    it 'should have the distances of the steps', :js => true do
      within('#leg-0') do
        within ("#step-0") do
          expect(first(".distance").text).to eq('0.6 mi')
        end

        within ("#step-1") do
          expect(first(".distance").text).to eq('0.8 mi')
        end
      end

      within('#leg-1') do
        within ("#step-1") do
          expect(first(".distance").text).to eq('0.6 mi')
        end
      end
    end
  end

  context 'two sight locations' do
    before(:each) do
      @location_2 = Location.create(street: "1445 Larimer St", city: "Denver", state: "CO")
      @sight_2 = Sight.create(name:"Gallup-Stanbury Building", kind: "historic landmark", location: @location_2)
      WalkLocation.create(walk_id: @walk.id, location_id: @location_2.id)
      visit walk_path(@walk)
    end

    it 'should have the sight locations', :js => true do
      expect(page).to have_content("Larimer")
      expect(page).to have_content("Welton")
    end

    it 'should have the directions from start to sight to end location', :js => true do
      within ("#leg-0") do
        within ("#step-0") do
          expect(first(".text").text).to eq("Head southeast on 15th St toward Market St")
        end
        within ("#step-1") do
          expect(first(".text").text).to include("Destination will be on")
        end
      end

      within ("#leg-1") do
        within ("#step-1") do
          expect(first(".text").text).to include("right onto 18th")
        end
      end
    end

    it 'should have the distances of the steps', :js => true do
      within ('#leg-0') do
        within ("#step-0") do
          expect(first(".distance").text).to eq('0.6 mi')
        end

        within ("#step-1") do
          expect(first(".distance").text).to eq('0.8 mi')
        end
      end

      within ('#leg-1') do
        within all("#step-1").last do
          expect(first(".distance").text).to eq('0.5 mi')
        end
      end
    end
  end
end
