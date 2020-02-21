require './lib/game'

class LeagueStatistics

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

  def sum_goals_per_team
    goals_per_team.transform_values do |goals|
      goals.sum
    end
  end

  def average_goals_per_team
    sum_goals_per_team.transform_values do |summed_goal|
       (summed_goal.to_f / goals_per_team.values.size).round(2)
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

  def games_teams_and_goals
    @games.reduce({}) do |games, game|
      games[game.game_id] = {game.home_team_id => game.home_goals, game.away_team_id => game.away_goals}
      games
    end
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
      (allowed_goals.sum.to_f / allowed_goals.size).round(2)
    end
  end

  def best_defense
    max_avg_allowed_goals_team_id = average_games_teams_and_allowed_goals.key(average_games_teams_and_allowed_goals.values.max)
    find_team_names(max_avg_allowed_goals_team_id)
  end

  def worst_defense
    min_avg_allowed_goals_team_id = average_games_teams_and_allowed_goals.key(average_games_teams_and_allowed_goals.values.min)
    find_team_names(min_avg_allowed_goals_team_id)
  end
end

# # best_defense
# average goals of other team per game...
# hash of game_id => {home_team_id => home_goals, away_team_id => away_goals}



# # 	Name of the team with the lowest average number of goals
# #   allowed per game across all seasons.
# # 	String
# #scored against them
# def average #module?
#   games_teams.goals(for home and away)
# end
#
# def best_defense
#   min_by average
#   return teams.team_name by game_teams.id
# end
#
# # worst_defense
# # 	Name of the team with the highest average number of goals
# #   allowed per game across all seasons.
# # 	String
# def average #module?
#   games_teams.goals(for home and away)
# end
#
# def worst_defense
#   max_by average
#   return teams.team_name by game_teams.id
# end
#
# # highest_scoring_visitor
# # 	Name of the team with the highest average score per game
# #   across all seasons when they are away.
# # 	String
# def average #module?
#   games_teams.goals(away)
# end
#
# def highest_scoring_visitor
#   max_by average
#   return teams.team_name by game_teams.id
# end
#
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
# # lowest_scoring_visitor
# # 	Name of the team with the lowest average score per game
# #   across all seasons when they are a visitor.
# # 	String
# def average #module?
#   games_teams.goals(away)
# end
#
# def lowest_scoring_visitor
#   min_by average
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
