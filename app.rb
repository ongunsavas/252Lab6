require 'sinatra'
require 'geokit'
require 'json'

get "/" do
	"Hello, world!"
end

get "/restaurants" do
	chicago = [Restaurant.new("Purple Pig", "500 N Michigan Ave, Chicago, IL 60611", "https://goo.gl/A3FawZ"),
		Restaurant.new("Boho House", "11 W Illinois St, Chicago, IL 60654", "http://goo.gl/aSaaM4"),
		Restaurant.new("Gibsons Steakhouse", "1028 N Rush St, Chicago, IL 60611","http://goo.gl/d2IpLm")]
	new_york = [Restaurant.new("Blue Ribbon", "119 Sullivan Street New York, NY 10012", "http://goo.gl/WduX77"),
		Restaurant.new("Barraca", "81 Greenwich Ave, New York, NY 10014", "https://goo.gl/a0XXKC"),
		Restaurant.new("Sip Sak", "928 2nd Ave, New York, NY 10022", "http://goo.gl/JSmQXW")]


	id = params[:id].to_i
	case id
	when 1
		chicago.sample.getName.to_json
	when 2
		new_york.sample.to_json
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

	def getName
		@name
	end
end