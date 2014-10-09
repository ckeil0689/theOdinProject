class Timer

	@@seconds
	@@minutes
	@@hours
	@@time_string

	def seconds

		@seconds = 0
		@minutes = 0
		@hours = 0
	end

	def seconds=(time)

		@seconds = time % 60
		@minutes = (time / 60) % 60  # 60 = seconds in 1 min
		@hours = time / 3600  # 3600 = seconds in 1 hour
	end

	def time_string

		# seconds int -> string
		addSeconds = @seconds.to_s
		addMinutes = @minutes.to_s
		addHours = @hours.to_s

		# ensure 0-9 are displayed as string of size 2
		addSeconds = "0" + addSeconds if addSeconds.size == 1
		addMinutes = "0" + addMinutes if addMinutes.size == 1
		addHours = "0" + addHours if addHours.size == 1

		@time_string = addHours + ":" + addMinutes + ":" + addSeconds
	end
end