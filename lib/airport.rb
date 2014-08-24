require_relative 'weather'

class Airport

	include Weather

	DEFAULT_CAPACITY = 50

	def initialize(options = {})
		@capacity = options.fetch(:capacity, capacity)
		@planes = options.fetch(:planes, planes)
		super
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	def planes
		@planes ||= []
	end

	def land(plane)
		raise "The airport has no more space!" if full?
		plane.land!
		planes << plane
	end

	def take_off(plane)
		raise "Takeoff not allowed in a storm!" if storm?
		plane.take_off!
		planes.delete(plane)
	end

	def full?
		planes.count == capacity
	end

end