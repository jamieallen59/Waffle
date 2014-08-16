post '/waffles' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
	t = Time.now
	time = t.strftime("%H:%M on %D")
	
	Waffle.create(:url => url, :title => title, :tags => tags, :time => time)
	redirect to('/')
end