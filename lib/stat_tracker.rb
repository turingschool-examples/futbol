require 'CSV'
require_relative 'game_statistics'
require_relative 'league_stats'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
    @game_statistics = GameStatistics.new(game_stats, game_teams_stats)
    @league_statistics = LeagueStatistics.new(teams_stats, @game_statistics)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def game_stats
    game_data = CSV.read(@games, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    hashed_game_data = game_data.map { |row| row.to_hash }
    hashed_game_data.each do |row|
      row.delete(:venue)
      row.delete(:venue_link)
    end
  end

  def game_teams_stats
    game_teams_data = CSV.read(@game_teams, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    hashed_game_teams_data = game_teams_data.map { |row| row.to_hash }
    hashed_game_teams_data.each do |row|
      row.delete(:pim)
      row.delete(:powerPlayOpportunities)
      row.delete(:powerPlayGoals)
      row.delete(:faceOffWinPercentage)
      row.delete(:giveaways)
      row.delete(:takeaways)
    end
  end

  def teams_stats
    teams_data = CSV.read(@teams, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    hashed_teams_data = teams_data.map { |row| row.to_hash }
    hashed_teams_data.each do |row|
      row.delete(:staduim)
    end
  end

  def highest_total_score
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    @game_statistics.percentage_ties
  end

  def count_of_games_by_season
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense
    @league_statistics.best_offense_stats
    @league_statistics.best_offense
  end

  def worst_offense
    @league_statistics.worst_offense_stats
    @league_statistics.worst_offense
  end

  def highest_scoring_visitor
    @league_statistics.team_highest_away_goals
    @league_statistics.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_statistics.team_highest_home_goals
    @league_statistics.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_statistics.team_lowest_away_goals
    @league_statistics.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_statistics.team_lowest_home_goals
    @league_statistics.lowest_scoring_home_team
  end
end
