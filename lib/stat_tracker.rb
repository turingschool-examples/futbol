require 'csv'
require_relative "./game_stats"
require_relative "./league_stats"

class StatTracker

  def initialize(game_path, team_path, game_team_path)
    @game_stat   = GameStats.new(game_path)
    @league_stat = LeagueStats.new(game_team_path, team_path, game_path)
    # @game_teams  = CSV.read(game_team_path)

  end

  def highest_total_score
    @game_stat.highest_total_score
  end

  def lowest_total_score
    @game_stat.lowest_total_score
  end

  def percentage_home_wins
    @game_stat.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stat.percentage_visitor_wins
  end

  def percentage_ties
    @game_stat.percentage_ties
  end

  def count_of_games_by_season
    @game_stat.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stat.average_goals_per_game
  end

  def average_goals_by_season
    @game_stat.average_goals_by_season
  end

  def count_of_teams
    @league_stat.count_of_teams
  end

  def best_offense
    @league_stat.best_offense
  end

  def worst_offense
    @league_stat.worst_offense
  end

  # def highest_scoring_visitor
  #   @league_stat.highest_scoring_visitor
  # end

  # def lowest_scoring_home_team
  #   @league_stat.lowest_scoring_home_team
  # end

  def to_array(file_path)
    rows = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      rows << row.to_h
    end
    rows
  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_team_path = locations[:game_teams]
    self.new(game_path, team_path, game_team_path)
  end
end
