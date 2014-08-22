class Airport

	def planes
		@planes ||= []
	end

	def land(plane)
		planes << plane
	end

	def take_off(plane)
		planes.delete(plane)
	end

end