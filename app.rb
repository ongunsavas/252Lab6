require 'sinatra'
require 'geokit'
require 'json'

get "/" do
  redirect 'index.html'
end

get "/restaurants" do
	chicago = [Restaurant.new("Purple Pig", "500 N Michigan Ave, Chicago, IL 60611", "https://goo.gl/A3FawZ"),
		Restaurant.new("Boho House", "11 W Illinois St, Chicago, IL 60654", "http://goo.gl/aSaaM4"),
		Restaurant.new("Gibsons Steakhouse", "1028 N Rush St, Chicago, IL 60611","http://goo.gl/d2IpLm")]
	new_york = [Restaurant.new("Blue Ribbon", "119 Sullivan Street New York, NY 10012", "http://goo.gl/WduX77"),
		Restaurant.new("Barraca", "81 Greenwich Ave, New York, NY 10014", "https://goo.gl/a0XXKC"),
		Restaurant.new("Sip Sak", "928 2nd Ave, New York, NY 10022", "http://goo.gl/JSmQXW")]

	address = params[:address].to_s
	id = locateCity(address)
	case id
	when 0
		chosen = chicago.sample
		{name: chosen.getName, address: chosen.getAddress, picture_url: chosen.getPicture}.to_json
	when 1
		chosen = new_york.sample
		{name: chosen.getName, address: chosen.getAddress, picture_url: chosen.getPicture}.to_json
	else
		"The city is not found in our database"
	end
end

helpers do 
	def locateCity(address)
		given_address = Geokit::Geocoders::GoogleGeocoder.geocode address.to_s
		new_york = Geokit::Geocoders::GoogleGeocoder.geocode '350 5th Ave, New York, NY 10118'
		chicago = Geokit::Geocoders::GoogleGeocoder.geocode '800 W Randolph St, Chicago, IL 60607'
		adress_db = [chicago, new_york]
		min = 100000000.00
		result = -1
		adress_db.each_with_index { |address, index|
			if min > address.distance_to(given_address)
				min = address.distance_to(given_address)
				result = index
			end
		}
		return result
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

	def getAddress
		@address
	end

	def getPicture
		@picture_url
	end
end