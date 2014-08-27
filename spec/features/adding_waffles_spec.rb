require 'spec_helper'

feature "User adds a new waffle" do

	scenario "when browsing the homepage" do
		expect(Waffle.count).to eq 0
		visit '/'
		add_waffle("http://www.makersacademy.com/", "Makers Academy")
		expect(Waffle.count).to eq 1
		waffle = Waffle.first
		expect(waffle.url).to eq "http://www.makersacademy.com/"
		expect(waffle.title).to eq "Makers Academy"
	end

	scenario "with a few tags" do
		visit '/'
		# save_and_open_page
		add_waffle("http://www.makersacademy.com/",
					"Makers Academy",
					['education', 'ruby'])
		waffle = Waffle.first
		expect(waffle.tags.map(&:text)).to include("education")
		expect(waffle.tags.map(&:text)).to include("ruby")
	end

	def add_waffle url, title, tags = []
		within('#new-waffle') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Send waffle'
		end
	end
end
