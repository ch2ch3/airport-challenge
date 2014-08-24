module Weather

	WEATHER_CONDITIONS = { 1 => :sunny, 2 => :sunny, 3 => :sunny, 4 => :sunny, 5 => :stormy }

	def initialize(options = {})
		@weather = rand(5) + 1
	end

	def change_weather!
		@weather = rand(5) + 1
	end

	def weather
		WEATHER_CONDITIONS.fetch(@weather)
	end

	def stormy?
		@weather >= 4
	end

end