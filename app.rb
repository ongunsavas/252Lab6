require 'sinatra'
require 'geokit'

get "/" do
	"Hello, world!"
end

get "/restaurants" do
	chicago = ["Purple Pig", "Boho House", "Gibsons"]
	new_york = ["Blue Ribbon", "Fogo", "Sipsak"]
	id = params[:id].to_i
	case id
	when 1
		chicago.sample
	when 2
		new_york.sample
	else
		"The city is not found in our database"
	end
end

class Restaurant
	def initialize(name, address, picture_url)
		@name = name
		@address = address
		@picture_url = picture_url
	end
end