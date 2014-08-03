class Tag

	include DataMapper::Resource

	has n, :waffles, :through => Resource

	property :id, 	Serial
	property :text, String

end