require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  def self.from_csv(file_path)
    game_path = file_path[:games]
    team_path = file_path[:teams]
    game_team_path = file_path[:game_teams]

    StatTracker.new(game_path, team_path, game_team_path)
  end

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path =  game_path
    @team_path = team_path
    @game_team_path = game_team_path
  end

  def games
    Game.from_csv(@game_path)
    Game.all_games
  end

  def teams
    Team.from_csv(@team_path)
    Team.all_teams
  end

  def game_teams
    GameTeam.from_csv(@game_team_path)
    GameTeam.all_game_teams
  end
  
  def average_goals_by_season
    # Need to figure out how to add all away_goals and home_goals for each season, then divide that by number of games in that season. Finally, turn that into a hash with seasons as keys, and the averages as a matching value.
    total_goals_per_game = games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end

    {}
  end
end
