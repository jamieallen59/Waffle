require "spec_helper"

describe Waffle do

	context "Demonstration of how datamapper works" do

		it 'should be created and then retrieved from the db' do
			expect(Waffle.count).to eq 0
			Waffle.create(:title => "Makers Academy",
						  :url => "http://www.makersacademy.com/")
			expect(Waffle.count).to eq 1
			link = Waffle.first
			expect(link.url).to eq("http://www.makersacademy.com/")
			expect(link.title).to eq("Makers Academy")
			link.destroy
			expect(Waffle.count).to eq 0
		end
	end
end