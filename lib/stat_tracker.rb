require 'csv'
require_relative './game_stats'
require_relative './league_stats'
require_relative './season_stats'
require_relative './team_stats'

class StatTracker
  include GameStats
  include LeagueStats
  include SeasonStats
  include TeamStats
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = read_data(games)
    @teams = read_data(teams)
    @game_teams = read_data(game_teams)
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.open(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.open(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end

  def read_data(data)
    list_of_data = []
    data.each do |row|
      list_of_data << row
    end
    list_of_data
  end

# Game Statistics Calls
#   def highest_total_score
#     @game_stats.highest_total_score
#   end

#   def lowest_total_score
#     @game_stats.lowest_total_score
#   end

#   def percentage_home_wins
#     @game_stats.percentage_home_wins
#   end

#   def percentage_visitor_wins
#     @game_stats.percentage_visitor_wins
#   end

#   def percentage_ties
#     @game_stats.percentage_ties
#   end

#   def count_of_games_by_season(team_id = false)
#     @game_stats.count_of_games_by_season(team_id)
#   end

#   def average_goals_per_game
#     @game_stats.average_goals_per_game
#   end

#   def average_goals_by_season
#     @game_stats.average_goals_by_season
#   end

# # Team Statistics Calls
#   def team_info(team_id)
#     @team_stats.team_info(team_id)
#   end

#   def best_season(team_id)
#     @team_stats.best_season(team_id)
#   end

#   def worst_season(team_id)
#     @team_stats.worst_season(team_id)
#   end

#   def average_win_percentage(team_id)
#     @team_stats.average_win_percentage(team_id)
#   end

#   def most_goals_scored(team_id)
#     @team_stats.most_goals_scored(team_id)
#   end

#   def fewest_goals_scored(team_id)
#     @team_stats.fewest_goals_scored(team_id)
#   end

#   def favorite_opponent(team_id)
#     @team_stats.favorite_opponent(team_id)
#   end

#   def rival(team_id)
#     @team_stats.rival(team_id)
#   end

# League Statistics Methods

  

# Season statistics
  
end
