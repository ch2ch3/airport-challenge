require 'airport'
require 'plane'
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

		context "weather conditions" do

			it "does not allow a plane to take off when there is a storm" do
				expect(airport_with_plane).to receive(:stormy?).and_return(true)
				expect{ airport_with_plane.take_off(plane) }.to raise_error
			end

			it "does not allow a plane to land in the middle of a storm" do
				expect(airport).to receive(:stormy?).and_return(true)
				expect{ airport.land(plane) }.to raise_error
			end

		end

	end

end

describe "The Grand Finale" do

	let(:airport) { Airport.new(capacity: 6) }

	plane_1 = Plane.new
	plane_2 = Plane.new
	plane_3 = Plane.new
	plane_4 = Plane.new
	plane_5 = Plane.new
	plane_6 = Plane.new

	TEST_PLANES = [plane_1, plane_2, plane_3, plane_4, plane_5, plane_6]

	def land_all_planes
		expect(airport).to receive(:stormy?).exactly(6).times.and_return(false)
		TEST_PLANES.each do |plane|
			airport.land(plane)
		end
	end

	def take_off_all_planes
		expect(airport).to receive(:stormy?).exactly(6).times.and_return(false)
		TEST_PLANES.each do |plane|
			airport.take_off(plane)
		end
	end

	it "all planes can land" do
		land_all_planes
		expect(airport.planes).to eq [plane_1, plane_2, plane_3, plane_4, plane_5, plane_6]
	end

	it "airport is full after landing all planes" do
		land_all_planes
		expect(airport.full?).to be true
	end

	it "all planes have a status of landed" do
		land_all_planes
		airport.planes.each do |plane|
			expect(plane.status).to be :landed
		end
	end

	it "all planes can take off" do
		land_all_planes
		take_off_all_planes
		expect(airport.planes).to eq []
	end

	it "all planes have a status of flying" do
		land_all_planes
		take_off_all_planes
		TEST_PLANES.each do |plane|
			expect(plane.status).to be :flying
		end
	end

end