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

  def average_goals_per_team
    goals_per_team.transform_values do |goals|
      (goals.sum.to_f / goals.size).round(2)
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
      (allowed_goals.sum.to_f / allowed_goals.size).round(2)
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
      visitor_games[game.away_team_id] = [] if visitor_games[game.away_team_id].nil?
      visitor_games[game.away_team_id] << game.away_goals
      visitor_games
    end
  end

  def average_visiting_teams_and_goals
    visiting_teams_and_goals.transform_values do |goals|
      (goals.sum.to_f / goals.size).round(2)
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
    @games.reduce({}) do |home_games, game|
      home_games[game.home_team_id] = [] if home_games[game.home_team_id].nil?
      home_games[game.home_team_id] << game.home_goals
      home_games
    end
  end

  def average_home_teams_and_goals
    home_teams_and_goals.transform_values do |goals|
      (goals.sum.to_f / goals.size).round(2)
    end
  end

  def highest_scoring_home_team
    max_home_scores = average_home_teams_and_goals.key(average_home_teams_and_goals.values.max)
    find_team_names(max_home_scores)
  end

  def lowest_scoring_home_team
    min_home_scores = average_home_teams_and_goals.key(average_home_teams_and_goals.values.min)
    find_team_names(min_home_scores)
  end

  def game_team_results
    @game_teams.reduce({}) do |results_hash, game_team|
      results_hash[game_team.team_id] = [] if results_hash[game_team.team_id].nil?
      results_hash[game_team.team_id] << game_team.result
      results_hash
    end
  end

  def percent_wins
    game_team_results.transform_values do |results|
      wins = (results.find_all { |result| result == "WIN"})
      percent = ((wins.length.to_f / results.length) * 100).round(2)
      percent
    end
  end

  def winningest_team
    max_percent_wins = percent_wins.key(percent_wins.values.max)
    find_team_names(max_percent_wins)
  end
end


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
