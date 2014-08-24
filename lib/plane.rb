class Plane

	attr_accessor :status

	def initialize
		take_off!
	end

	def take_off!
		@status = :flying
		self
	end

	def land!
		@status = :landed
		self
	end

end