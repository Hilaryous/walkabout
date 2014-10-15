require 'rails_helper'

describe 'Visiting the homepage' do
	before(:each) do
		visit root_path
	end
	it "shouldn't fail" do
		expect(page.status_code).to eq 200
	end

	it "should have the name of the app" do
		expect(page).to have_link("Walkabout")
	end

	it "should have a link to see all the sights" do
		expect(page).to have_link("Sightsee")
	end

	it "should have a link to make a walk in the navbar" do
		expect(page).to have_link("Take a Walk")
	end

	it "should have a big button to make a walk" do
		expect(page).to have_link("Take a Walk")
	end

	it "should have a link to about us" do
		expect(page).to have_link("About Me")
	end

	it 'should have a link to the source code' do
		expect(page).to have_link("Hilaryous")
	end

	it 'should have a link to contact us' do
		expect(page).to have_link("Contact")
	end
end
