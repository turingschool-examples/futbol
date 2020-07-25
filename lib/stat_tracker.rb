require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'
require './lib/modable'

class StatTracker

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

  def average_goals_per_game
    total_goals = @game_manager.collect_all_goals
    @game_manager.average_goals_per_game(total_goals)
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
# p stats.rival(18)
