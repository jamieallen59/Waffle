require 'spec_helper'

feature 'User browses the list of waffles' do

	before(:each) {
		Waffle.create(:url => "https://www.makersacademy.com/",
					  :title => "Makers Academy",
					  :tags => [Tag.first_or_create(:text => 'education')])
		Waffle.create(:url => "https://www.google.com/",
					  :title => "Google",
					  :tags => [Tag.first_or_create(:text => 'search')])
		Waffle.create(:url => "https://www.bing.com/",
					  :title => "Bing",
					  :tags => [Tag.first_or_create(:text => 'search')])
		Waffle.create(:url => "https://www.code.org/",
					  :title => "Code.org",
					  :tags => [Tag.first_or_create(:text => 'education')])
	}

	scenario "When opening the homepage" do
		visit '/'
		expect(page).to have_content("Makers Academy")
	end

	scenario "filtered by a tag" do
		visit'/tags/search'
			expect(page).not_to have_content("Makers Academy")
			expect(page).not_to have_content("Code.org")
			expect(page).to have_content("Google")
			expect(page).to have_content("Bing")
	end

end