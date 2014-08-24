require 'plane'

describe Plane do

	let(:plane) { Plane.new }

	it "has a flying status when created" do
		expect(plane.status).to be :flying
	end

	it "can take off" do
		expect{ plane.take_off! }.not_to raise_error
	end

	it "changes its status to flying after taking off" do
		plane.take_off!
		expect(plane.status).to be :flying
	end

	it "can land" do
		expect{ plane.land! }.not_to raise_error
	end

	it "changes its status to landed after landing" do
		plane.take_off!.land!
		expect(plane.status).to be :landed
	end

end