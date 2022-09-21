require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @game = Game.new(@games_data)
    @league = League.new(@teams_data, @game_teams_data)
    @season = Season.new(@teams_data, @game_teams_data)
    @team = Team.new(@teams_data, @game_teams_data, @games_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game Statistics
  def total_game_goals
    @game.total_game_goals
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def count_of_goals_by_season
    @game.count_of_goals_by_season
  end

  def average_goals_per_game
    @game.average_goals_per_game
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  # League Statistics
  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

  # Season Statistics
  def winningest_coach(campaign)
    @season.winningest_coach(campaign)
  end

  def worst_coach(campaign)
    @season.worst_coach(campaign)
  end

  def most_accurate_team(campaign)
    @season.most_accurate_team(campaign)
  end

  def least_accurate_team	(campaign)
    @season.least_accurate_team(campaign)
  end

  def most_tackles(campaign)
    @season.most_tackles(campaign)
  end

  def fewest_tackles(campaign)
    @season.fewest_tackles(campaign)
  end
  
  # Team Statistics  
  def season
    @team.season
  end

  def season_hash(team)
    @team.season_hash(team)
  end

  def season_average_percentage(team)
    @team.season_average_percentage(team)
  end

  def best_season(team)
    @team.best_season(team)
  end

  def worst_season(team)
    @team.worst_season(team)
  end

  def team_info(team)
    @team.team_info(team)
  end

  def best_season(team)
    @team.best_season(team)
  end

  def worst_season(team)
    @team.worst_season(team)
  end

  def average_win_percentage(team)
    @team.average_win_percentage(team)
  end

  def most_goals_scored(team)
    @team.most_goals_scored(team)
  end

  def fewest_goals_scored(team)
    @team.fewest_goals_scored(team)
  end

  def favorite_opponent(team)
    @team.favorite_opponent(team)
  end

  def rival(team)
    @team.rival(team)
  end
end
