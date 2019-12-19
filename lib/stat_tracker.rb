require_relative 'game'
require_relative 'game_collection'



class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path
  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
  end

  def highest_total_score
    @game_collection.highest_total_score
  end
end
