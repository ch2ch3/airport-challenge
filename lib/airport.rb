class Airport

	DEFAULT_CAPACITY = 50

	attr_writer :capacity

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	def planes
		@planes ||= []
	end

	def land(plane)
		raise "The airport has no more space!" if full?
		planes << plane
	end

	def take_off(plane)
		planes.delete(plane)
	end

	def full?
		planes.count == capacity
	end

end