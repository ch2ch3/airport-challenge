module Weather

	WEATHER_CONDITIONS = { 1 => :sunny, 2 => :sunny, 3 => :sunny, 4 => :sunny, 5 => :stormy }

	def initialize(options = {})
		@weather = rand(4) + 1
	end

	def change_weather!
		@weather = rand(4) + 1
	end

	def weather
		WEATHER_CONDITIONS.fetch(@weather)
	end

	def storm?
		@weather == 5
	end

end