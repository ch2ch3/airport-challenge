require 'airport'
require 'plane'
require 'weather_spec'

describe Airport do

	let(:airport)            { Airport.new                  }
	let(:airport_with_plane) { Airport.new(planes: [plane]) }
	let(:plane)              { double :plane, land!: nil, take_off!: nil    }

	context "at initialisation" do

		it "has a default capacity" do
			expect(airport.capacity).to eq 50
		end

		it "can be initialised with planes" do
			airport = Airport.new(planes: [plane, plane])
			expect(airport.planes.count).to eq 2
		end

		it_behaves_like "a place"

	end

	context "taking off and landing" do

		it "can land a plane" do
			allow(airport).to receive(:stormy?).and_return(false)
			expect(plane).to receive(:land!).and_return(plane)
			airport.land(plane)
		end

		it "has a plane after landing it" do
			allow(airport).to receive(:stormy?).and_return(false)
			allow(plane).to receive(:land!).and_return(plane)
			airport.land(plane)
			expect(airport.planes).to eq [plane]
		end

		it "cannot land the same plane twice" do
			allow(airport).to receive(:stormy?).exactly(2).times.and_return(false)
			allow(plane).to receive(:land!).and_return(plane)
			airport.land(plane)
			expect{ airport.land(plane) }.to raise_error
		end

		it "can send a plane for take off" do
			allow(airport_with_plane).to receive(:stormy?).and_return(false)
			expect(plane).to receive(:take_off!)
			airport_with_plane.take_off(plane)
		end

		it "has no planes after they all take off" do
			allow(airport_with_plane).to receive(:stormy?).and_return(false)
			allow(plane).to receive(:take_off!)
			airport_with_plane.take_off(plane)
			expect(airport_with_plane.planes).to eq []
		end

		it "cannot send a plane for take off if it is not currently in the airport" do
			expect(airport).to receive(:stormy?).and_return(false)
			expect{ airport.take_off(plane) }.to raise_error
		end

	end

	context "traffic control" do

		it "a plane cannot land if the airport is full" do
			allow(airport).to receive(:stormy?).exactly(51).times.and_return(false)
			airport.capacity.times { airport.land(plane) }
			expect{ airport.land(plane) }.to raise_error
		end

		context "weather conditions" do

			it "checks the weather before allowing planes to land" do
				expect(airport).to receive(:stormy?)
				airport.land(plane)
			end

			it "does not allow a plane to land in the middle of a storm" do
				allow(airport).to receive(:stormy?).and_return(true)
				expect{ airport.land(plane) }.to raise_error
			end

			it "checks the weather before allowing planes to take off" do
				expect(airport_with_plane).to receive(:stormy?)
				airport_with_plane.take_off(plane)
			end

			it "does not allow a plane to take off when there is a storm" do
				allow(airport_with_plane).to receive(:stormy?).and_return(true)
				expect{ airport_with_plane.take_off(plane) }.to raise_error
			end

		end

	end

end

describe "The Grand Finale" do

	let(:airport) { Airport.new(capacity: 6) }

	TEST_PLANES = [Plane.new, Plane.new, Plane.new, Plane.new, Plane.new, Plane.new]

	def land_all_planes
		allow(airport).to receive(:stormy?).exactly(6).times.and_return(false)
		TEST_PLANES.each do |plane|
			airport.land(plane)
		end
	end

	def take_off_all_planes
		allow(airport).to receive(:stormy?).exactly(6).times.and_return(false)
		TEST_PLANES.each do |plane|
			airport.take_off(plane)
		end
	end

	it "all planes can land" do
		land_all_planes
		expect(airport.planes.count).to eq 6
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