#./lib/teams_factory.rb
require "csv"

class TeamsFactory
  attr_reader :teams

  def initialize
    @teams = []
  end

  def create_teams(database)
    contents = CSV.open database, headers: true, header_converters: :symbol

    @teams = contents.map do |team|
      team_id = team[:team_id].to_i
      franchise_id = team[:franchiseid].to_i
      team_name = team[:teamname]
      abbreviation = team[:abbreviation]
      stadium = team[:stadium]

      Team.new(team_id, franchise_id, team_name, abbreviation, stadium)
    end
  end
end