require_relative '../lib/team'

class TeamCollection

	def initialize(location)
		@teams_array = []
		CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
			@teams_array << Team.new(row)
		end
	end
end