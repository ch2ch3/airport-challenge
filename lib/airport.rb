require_relative 'weather'

class Airport

	include Weather

	DEFAULT_CAPACITY = 50

	def initialize(options = {})
		@capacity = options.fetch(:capacity, capacity)
		@planes = options.fetch(:planes, planes)
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	def planes
		@planes ||= []
	end

	def land(plane)
		raise "Landing not allowed in a storm!" if stormy?
		raise "The airport has no more space!" if full?
		raise "The plane has already been landed." if has_landed?(plane)
		planes << plane.land!
	end


	def take_off(plane)
		raise "Takeoff not allowed in a storm!" if stormy?
		raise "That plane isn't here." unless has_landed?(plane)
		planes.delete(plane).take_off!
	end

	def full?
		planes.count == capacity
	end
	
	def has_landed?(plane)
		planes.include?(plane)
	end

end