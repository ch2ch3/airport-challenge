require 'weather'

class Place; include Weather; end

describe Place do

	it "has a weather" do
		place = Place.new
		expect(place.weather.nil?).to be false
	end

	it "is either sunny or stormy" do
		place = Place.new
		expect(place.weather).to eq :sunny || :stormy
	end

end