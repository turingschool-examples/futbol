require_relative "game"
require_relative "team"
require_relative "game_team"

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)
    @games_file_path = locations[:games]
    @teams_file_path = locations[:teams]
    @game_teams_file_path = locations[:game_teams]
    StatTracker.new(@games_file_path, @teams_file_path, @game_teams_file_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    Team.from_csv(teams_path)
    GameTeam.from_csv(game_teams_path)

    @games = Game.accumulator
    @teams = Team.accumulator
    @game_teams = GameTeam.accumulator
  end

  def count_of_teams
    Team.accumulator.count
  end

  def percentage_ties
    GameTeam.percentage_ties
  end

  def count_of_games_by_season
    games_by_season = @games.group_by do |game|
       game.season
     end
    games_by_season.transform_values { |season| season.length }
  end
end
