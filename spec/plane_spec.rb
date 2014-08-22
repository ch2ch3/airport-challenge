require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes off from the airport, the plane's status should become "flying"

describe Plane do

  let(:plane) { Plane.new }
  
  it "has a flying status when created" do
    expect(plane.flying?).to be true
  end
  
  xit 'has a flying status when in the air' do
  end
  
  it "can take off" do
    expect{ plane.take_off! }.not_to raise_error
  end
  
  it "changes its status to flying after taking off" do
    plane.take_off!
    expect(plane.flying?).to be true
  end

end