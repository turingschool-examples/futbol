require 'csv'

class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchise_id]
    @team_name = info[:team_name]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end

  def self.create_teams(team_data)
		teams = []
		CSV.foreach team_data, headers: true, header_converters: :symbol do |row|
			teams << Team.new(row)
		end
		teams
	end
end