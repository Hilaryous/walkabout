require 'rails_helper'

describe 'sight' do
  context 'index' do
    before(:each) do
      @location  = create(:location)
      @sight = create(:sight, :location => @location)
      visit sights_path
    end

    it "shouldn't fail" do
      expect(page.status_code).to eq 200
    end

    it 'should have the name of a sight' do
      expect(page).to have_content @sight.name
    end

    it 'it should have the sight type' do
      expect(page).to have_content @sight.kind
    end

    it 'should have the address of the sight' do
      expect(page).to have_content @sight.location.address
    end

    it 'should have an image of the sight' do
      expect(page.find('#sight-image')['src']).to eq @sight.image.url(:thumb)
    end

    it 'should have all of the kinds of sights' do
      expect(page).to have_content('Park')
    end
  end

  context 'show' do
    before(:each) do
      @location  = create(:location)
      @sight = create(:sight, :location => @location)
      visit sights_path(@sight)
    end

    it "shouldn't fail" do
      expect(page.status_code).to eq 200
    end

    it 'should have the name of a sight' do
      expect(page).to have_content @sight.name
    end

    it 'it should have the sight type' do
      expect(page).to have_content @sight.kind
    end

    it 'should have the address of the sight' do
      expect(page).to have_content @sight.location.address
    end

    it 'should have an image of the sight' do
      expect(page.find('#sight-image')['src']).to eq @sight.image.url(:thumb)
    end
  end
end
