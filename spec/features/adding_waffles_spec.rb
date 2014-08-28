require 'spec_helper'

feature "User adds a new waffle" do

	scenario "when browsing the homepage" do
		expect(Waffle.count).to eq 0
		visit '/'
		add_waffle("Makers Academy", "http://www.makersacademy.com/")
		expect(Waffle.count).to eq 1
		waffle = Waffle.first
		expect(waffle.url).to eq "http://www.makersacademy.com/"
		expect(waffle.title).to eq "Makers Academy"
	end

	scenario "with a few tags" do
		visit '/'
		# save_and_open_page
		add_waffle("Makers Academy",
							 "http://www.makersacademy.com/",
							 ['education', 'ruby'])
		waffle = Waffle.first
		expect(waffle.tags.map(&:text)).to include("education")
		expect(waffle.tags.map(&:text)).to include("ruby")
	end

	def add_waffle text, url, tags = []
		within('#new-waffle') do
			fill_in 'title', :with => text
			fill_in 'url', :with => url
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Send waffle'
		end
	end

	context 'Then someone replies' do
		it 'displays an input box to allow a reply' do
			sign_up
			visit '/'
			add_waffle("Makers Academy", "http://www.makersacademy.com/")
			click_button('Reply')

			expect(page).to have_content 'Respond to this waffle here...'
		end

		it 'displays the reply below the waffle' do
			sign_up
			visit '/'
			add_waffle("Makers Academy", "http://www.makersacademy.com/")
			click_button('Reply')
			fill_in 'Reply', :with => 'What on earth?'

			expect(page).to have_content 'What on earth?'
		end
	end
end
