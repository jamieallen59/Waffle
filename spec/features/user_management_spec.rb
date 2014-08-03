require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User Signs up" do

	scenario "when being logged out" do
		expect(lambda { sign_up }).to change(User, :count).by 1
		# lambda { sign_up }.should change(User, :count).by 1
		expect(page).to have_content("Welcome, alice101")
		expect(User.first.email).to eq("alice@example.com")
	end

	scenario "with and email that is already registered" do
		lambda { sign_up }.should change(User, :count).by 1
		lambda { sign_up }.should change(User, :count).by 0
		expect(page).to have_content("This email is already taken")
	end


	scenario "with a password that doesn't match" do
		lambda { sign_up('a@a.com', 'pass', 'wrong', 'Alice', 'alice101') }.should change(User, :count).by 0
		expect(current_path).to eq '/users'
		expect(page).to have_content("Invalid password confirmation. Please try again")
	end

end

feature "User signs in" do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test',
					:name => 'Testy Test',
					:username => 'Testman101')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("welcome, Testman101")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, Testman101")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, Testman101")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature "User signs out" do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test',
					:name => 'Testy Test',
					:username => 'Testman101')
	end

	scenario "while being signed in" do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, Testman101")
	end
end



