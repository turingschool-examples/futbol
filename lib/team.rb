require './required_files'

class Team
	attr_reader :team_id,
							:franchise_id,
							:team_name,
							:abbreviation,
							:stadium,
							:link

	def initialize(row)
    @team_id = row[:team_id].to_i
    @franchise_id = row[:franchiseid]
    @team_name = row[:teamname]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @link = row[:link]
	end

	def self.create_teams(teams_hash)
		team_arr = []
		teams_hash.each do |row|
			team_arr << Team.new(row)
		end
		return team_arr
	end
end
