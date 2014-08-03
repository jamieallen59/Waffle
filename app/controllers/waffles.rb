post '/waffles' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
	Waffle.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end