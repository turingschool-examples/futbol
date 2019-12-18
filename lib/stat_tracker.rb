require './lib/games'

class StatTracker

  attr_reader :game_teams_path, :games, :teams_path

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    game_path = locations[:games]
    teams_path = locations[:teams]

    StatTracker.new(game_teams_path, game_path, teams_path)
  end

  def initialize(game_teams_path, game_path, teams_path)
    @game_teams_path = game_teams_path
    @teams_path = teams_path
    @games = Games.from_csv(game_path)
  end

  def highest_total_score
    @games.all.highest_total_score
  end

  def lowest_total_score
    @games.all.lowest_total_score
  end

  def biggest_blowout
    @games.all.biggest_blowout
  end

  def percentage_home_wins
    @games.all.percentage_home_wins
  end

  def percentage_visitor_wins
    @games.all.percentage_visitor_wins
  end

  def percentage_ties
    @games.all.percentage_ties
  end

  def count_of_games_by_season
    @games.all.count_of_games_by_season
  end

  def average_goals_per_game
    @games.all.average_goals_per_game
  end

  def average_goals_by_season
    @games.all.average_goals_by_season
  end
end
