require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'
require './lib/modable'

class StatTracker
  include Modable

  attr_reader :game_manager, :game_teams_manager, :team_manager

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)

    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    @game_teams_manager = GameTeamsManager.new(game_teams_path)
    @game_manager = GameManager.new(game_path)
    @team_manager = TeamManager.new(team_path)
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
  end

  def percentage_home_wins
    home_games = @game_teams_manager.count_home_games
    home_wins = @game_teams_manager.home_game_results(home_games)
   @game_teams_manager.percentage_home_wins(home_games, home_wins[:wins])
  end

  def percentage_visitor_wins
    home_games = @game_teams_manager.count_home_games
    home_losses = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_visitor_wins(home_games, home_losses[:losses])
  end

  def count_of_games_by_season
    games_by_season = @game_manager.create_games_by_season_array
    @game_manager.count_of_games_by_season(games_by_season)
  end

  def percentage_ties
    home_games = @game_teams_manager.count_home_games
   tie_games = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_ties(home_games, tie_games[:ties])
  end

  def team_info(id)
    @team_manager.team_info(id)
  end

  def best_season(id)
    @game_manager.best_season(id)
  end

  def worst_season(id)
    @game_manager.worst_season(id)
  end

  def average_win_percentage(id)
    @game_manager.average_win_percentage(id)
  end

  def most_goals_scored(id)
    @game_manager.most_goals_scored(id)
  end

  def fewest_goals_scored(id)
    @game_manager.fewest_goals_scored(id)
  end

  def favorite_opponent(id)
    number = @game_manager.favorite_opponent(id)
    @team_manager.teams_array.select{ |team| team.team_id == number}[0].team_name
  end

  def rival(id)
    number = @game_manager.rival(id)
    @team_manager.teams_array.select{ |team| team.team_id == number}[0].team_name
  end

  def count_of_teams
    @team_manager.size
  end

  def best_offense
    @game_teams_manager.teams_sort_by_average_goal.last.team_name
  end

  def worst_offense
    @game_teams_manager.teams_sort_by_average_goal.first.team_name
  end

  def lowest_home_team
    @game_teams_array.lowest_home_team
  end
  #season stats start here (Drew's)
  def winningest_coach(season)
    @all_games = @game_manager.winningest_coach(season)
    self.winningest_coach1(season)
    @result.max_by(&:last).first
  end

  def worst_coach(season)
    @all_games1 = @game_manager.worst_coach(season)
    self.worst_coach1(season)
    @result.sort_by { |key, value| value}[-1].first
  end

end


# game_path = './data/games.csv'
# team_path = './data/teams.csv'
# game_teams_path = './data/game_teams.csv'
#
# locations = {
#   games: game_path,
#   teams: team_path,
#   game_teams: game_teams_path
# }
#
# stats = StatTracker.from_csv(locations)
# p stats.worst_coach("20142015")
