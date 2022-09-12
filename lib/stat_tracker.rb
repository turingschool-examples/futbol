require 'csv'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data

  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    games_data = CSV.open game_path, headers:true
    teams_data = CSV.open team_path, headers:true
    game_teams_data = CSV.open game_teams_path, headers:true
    StatTracker.new(games_data, teams_data, game_teams_data)

  end

  def test
    @games_data.map do|row|
      row["game_id"]
    end
  end
end
