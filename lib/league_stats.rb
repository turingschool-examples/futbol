require 'csv'
require 'simplecov'

SimpleCov.start

class LeagueStats
  attr_reader :league_data
  def initialize(league_data)
    #@league_data = CSV.read("./data/sample_game_teams.csv")
    @league_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
  end

  def count_of_teams
    team_ids = []
    @league_data.each do |league|
      if team_ids.include?(league["team_id"])
      else
        team_ids << league["team_id"]
      end
    end
    p team_ids.count
  end
end
