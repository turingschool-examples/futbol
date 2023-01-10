require 'csv'

class Team
  attr_reader :info

  def initialize(data)
    @info = {
      team_id: data[:team_id].to_i,
      franchise_id: data[:franchiseid].to_i,
      team_name: data[:teamname],
      abbreviation: data[:abbreviation],
      stadium: data[:stadium],
      link: data[:link]
    }
  end

  def self.create_teams(team_data)
		teams = []
		CSV.foreach team_data, headers: true, header_converters: :symbol do |row|
			teams << Team.new(row)
		end
		teams
	end
end