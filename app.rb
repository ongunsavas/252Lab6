require 'sinatra'
get "/" do
	"Hello, world!"
end
get "restaurants" do
	chicago = ["Purple Pig", "Boho House", "Gibsons"]
	new_york = ["Blue Ribbon", "Fogo", "Sipsak"]
	case params[:id]
	when 1
		chicago.sample
	when 2
		new_york.sample
	else
		"The city is not found in our database"
		end
end