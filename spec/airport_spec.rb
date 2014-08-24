require 'airport'
require 'weather_spec'

describe Airport do

	let(:airport)            { Airport.new                  }
	let(:airport_with_plane) { Airport.new(planes: [plane]) }
	let(:plane)              { Plane.new                    }

	context "at initialisation" do

		it "has a default capacity" do
			expect(airport.capacity).to eq 50
		end

		it "can be initialised with planes" do
			airport = Airport.new(planes: [Plane.new, Plane.new])
			expect(airport.planes.count).to eq 2
		end

		it_behaves_like "a place"

	end

	context "taking off and landing" do

		it "can land a plane" do
			expect(airport).to receive(:stormy?).and_return(false)
			airport.land(plane)
			expect(airport.planes).to eq [plane]
		end

		it "can send a plane for take off" do
			expect(airport).to receive(:stormy?).exactly(2).times.and_return(false)
			airport.land(plane)
			airport.take_off(plane)
			expect(airport.planes).to eq []
		end

		it "cannot send a plane for take off if it is not currently in the airport" do
			expect(airport).to receive(:stormy?).and_return(false)
			expect{ airport.take_off(plane) }.to raise_error
		end

	end

	context "traffic control" do

		it "a plane cannot land if the airport is full" do
			expect(airport).to receive(:stormy?).exactly(51).times.and_return(false)
			airport.capacity.times { airport.land(Plane.new) }
			expect{ airport.land(plane) }.to raise_error
		end

		# Include a weather condition using a module.
		# The weather must be random and only have two states "sunny" or "stormy".
		# Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
		# 
		# This will require stubbing to stop the random return of the weather.
		# If the airport has a weather condition of stormy,
		# the plane can not land, and must not be in the airport

		context "weather conditions" do

			it "a plane cannot take off when there is a storm brewing" do
				expect(airport_with_plane).to receive(:stormy?).and_return(true)
				expect{ airport_with_plane.take_off(plane) }.to raise_error
			end

			it 'a plane cannot land in the middle of a storm' do
				expect(airport).to receive(:stormy?).and_return(true)
				expect{ airport.land(plane) }.to raise_error
			end

		end

	end

end

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "the grand finale (last spec)" do

xit 'all planes can land and all planes can take off' do
end

end