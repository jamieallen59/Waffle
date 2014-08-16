get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@waffles = tag ? tag.waffles : []
	erb :index
end