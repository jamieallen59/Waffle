get '/' do
	@waffles = Waffle.all
	erb :index
end
