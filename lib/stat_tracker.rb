require_relative 'game_collection'
require_relative 'game_teams_collection'

class StatTracker
  attr_reader :game_path, :game_teams_path

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, game_teams_path)
  end

  def initialize(game_path, game_teams_path)
    @game_teams = GameTeamsCollection.new(game_teams_path)
    @games = GameCollection.new(game_path)
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def biggest_blowout
    @games.biggest_blowout
  end

  def percentage_home_wins
    @games.percentage_home_wins
  end

  def percentage_visitor_wins
    @games.percentage_visitor_wins
  end

  def percentage_ties
    @games.percentage_ties
  end

  def count_of_games_by_season
    @games.games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end
end
