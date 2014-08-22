class Airport

	def planes
		@planes ||= []
	end

	def land(plane)
		planes << plane
	end

end