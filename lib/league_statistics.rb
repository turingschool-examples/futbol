require './lib/game'
require './lib/modules/calculable'
require './lib/modules/hashable'

class LeagueStatistics
  include Calculable
  include Hashable

  def initialize
    @teams = Team.all
    @games = Game.all
    @game_teams = GameTeam.all
  end

  def count_of_teams
    @teams.size
  end

  def find_team_names(team_id)
    match_team = @teams.find do |team|
      team.team_id == team_id
    end
    match_team.team_name
  end

  def goals_per_team
    @game_teams.reduce({}) do |goals_per_team, game_team|
      goals_per_team[game_team.team_id] = [] if goals_per_team[game_team.team_id].nil?
      goals_per_team[game_team.team_id] << game_team.goals
      goals_per_team
    end
  end

  def average_goals_per_team
    goals_per_team.transform_values do |goals|
      average(goals.sum.to_f, goals.size)
    end
  end

  def best_offense
    max_avg_goal_team_id = average_goals_per_team.key(average_goals_per_team.values.max)
    find_team_names(max_avg_goal_team_id)
  end

  def worst_offense
    min_avg_goal_team_id = average_goals_per_team.key(average_goals_per_team.values.min)
    find_team_names(min_avg_goal_team_id)
  end

  def games_teams_and_allowed_goals
    @games.reduce({}) do |teams_allowed_goals, game|
      teams_allowed_goals[game.home_team_id] = [] if teams_allowed_goals[game.home_team_id].nil?
      teams_allowed_goals[game.away_team_id] = [] if teams_allowed_goals[game.away_team_id].nil?

      teams_allowed_goals[game.home_team_id] << game.away_goals
      teams_allowed_goals[game.away_team_id] << game.home_goals

      teams_allowed_goals
    end
  end

  def average_games_teams_and_allowed_goals
    games_teams_and_allowed_goals.transform_values do |allowed_goals|
      average(allowed_goals.sum.to_f, allowed_goals.size)
    end
  end

  def best_defense
    min_avg_allowed_goals_team_id = average_games_teams_and_allowed_goals.key(average_games_teams_and_allowed_goals.values.min)
    find_team_names(min_avg_allowed_goals_team_id)
  end

  def worst_defense
    max_avg_allowed_goals_team_id = average_games_teams_and_allowed_goals.key(average_games_teams_and_allowed_goals.values.max)
    find_team_names(max_avg_allowed_goals_team_id)
  end

  def visiting_teams_and_goals
    @games.reduce({}) do |visitor_games, game|
      hash_builder(visitor_games, game.away_team_id, game.away_goals)
    end
  end

  def average_visiting_teams_and_goals
    visiting_teams_and_goals.transform_values do |goals|
      average(goals.sum.to_f, goals.size)
    end
  end

  def highest_scoring_visitor
    max_visitor_scores = average_visiting_teams_and_goals.key(average_visiting_teams_and_goals.values.max)
    find_team_names(max_visitor_scores)
  end

  def lowest_scoring_visitor
    min_visitor_scores = average_visiting_teams_and_goals.key(average_visiting_teams_and_goals.values.min)
    find_team_names(min_visitor_scores)
  end

  def home_teams_and_goals
    @games.reduce({}) do |visitor_games, game|
      home_games[game.home_team_id] = [] if home_games[game.home_team_id].nil?
      home_games[game.home_team_id] << game.home_goals
      home_games
    end
  end

  def find_games_in_season(season)
    @games.find_all do |game|
      game.season == season
    end
  end

  def find_game_teams_in_season(season)
    @game_teams.find_all do |game_team|
      game_team_season = @games.find do |game|
        game.game_id == game_team.game_id
      end.season

      game_team_season == season
    end
  end

  def all_teams_playing
    @game_teams.map {|game_team| game_team.team_id}.uniq
  end

  def gameid_of_games_that_season(season_id)
    games_that_season = @games.find_all {|game| game.season == season_id}
    games_that_season.map {|game| game.game_id}
  end

  def game_teams_that_season(team_id, season_id)
    @game_teams.find_all do |game_team|
      gameid_of_games_that_season(season_id).include?(game_team.game_id) && game_team.team_id == team_id
    end
  end

  def create_hash_with_team_games_by_team(season_id)
    all_teams_playing.reduce({}) do |teams_and_games, team_id|
      teams_and_games[team_id] = game_teams_that_season(team_id, season_id)
      teams_and_games
    end
  end

  def tackles_per_team_in_season(team_id, season_id)
    create_hash_with_team_games_by_team(season_id)[team_id].sum { |game_team| game_team.tackles }
  end

  def most_tackles(season_id)
    team_id = all_teams_playing.max_by do |team|
      tackles_per_team_in_season(team, season_id)
    end
    find_team_names(team_id)
  end

  def fewest_tackles(season_id)
    team_id = all_teams_playing.min_by do |team|
      tackles_per_team_in_season(team, season_id)
    end
    find_team_names(team_id)
  end
end


  # def sum_of_tackles_by_team(season_id)
  #   tackles_per_team.transform_values do |tackles|
  #     tackles.sum
  #   end
  #
  # end

  # def most_tackles(season)
  #   max_tackles = average_visiting_teams_and_goals.key(average_visiting_teams_and_goals.values.max)
  #   find_team_names(max_visitor_scores)
  # end

  # def most_tackles(season_id)
  #   team_id = hash_key_max_by(sum_of_tackles_by_team)
  #   find_team_names(team_id)
  # end

#   def fewest_tackles(season_id)
#     team_id = hash_key_min_by(sum_of_tackles_by_team)
#     require "pry"; binding.pry
#     find_team_names(team_id)
#   end
# end



# # highest_scoring_home_team
# # 	Name of the team with the highest average score per game
# #   across all seasons when they are home.
# # 	String
# def average #module?
#   games_teams.goals(home)
# end
#
# def highest_scoring_home_team
#   max_by average
#   return teams.team_name by game_teams.id
# end
#

# # lowest_scoring_home_team
# # 	Name of the team with the lowest average score per game across all seasons when they are at home.
# # 	String
# def average #module?
#   games_teams.goals(home)
# end
#
# def lowest_scoring_home_team
#   min_by average
#   return teams.team_name by game_teams.id
# end
#
# # winningest_team
# # 	Name of the team with the highest win percentage across
# #   all seasons.
# # 	String
# def percentage # module?
#   game_teams.result == win
# end
#
# def winningest_team
#   max_by percentage
#   return teams.team_name by game_teams.team_id
# end
#
# # best_fans
# # 	Name of the team with biggest difference between home
# #   and away win percentages.
# # 	String
# def percentage # module?
#   game_teams.result == win (one for home, one for away?)
# end
#
# def best_fans
#   max_by away_percentage - home_percentage
#   return teams.team_name by game_teams.team_id
# end
#
# # worst_fans
# # 	List of names of all teams with better away records
# #   than home records.
# # 	Array
# def percentage # module?
#   game_teams.result == win (one for home, one for away?)
# end
#
# def worst_fans
#   find_all
#   away_percentage > home_percentage
#   match array with teams.team_name by game_teams.team_id
# end
