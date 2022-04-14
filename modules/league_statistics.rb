require './lib/game_teams'
require './lib/team_stats'
require 'pry'

module LeagueStats


  def count_of_teams
    teams = GameTeams.create_list_of_game_teams(@game_teams)
    teams.map { |team| team.team_id}.uniq.length
  end
  #
  # def goals_by_team
  #   goals_by_team = []
  #   game_teams = GameTeams.create_list_of_game_teams(@game_teams)
  #   game_teams.each do |game_team| game_team.team_id
  #     goals_by_team << game_team.goals.to_i
  #   end
  #   goals_by_team
  #   # binding.pry
  # end
  #
  # def average_goals_by_team
  #   average_team_goals
  #   average = goals_by_team.map { |team| team.goals.sum.to_f / team.goals.size}.round(2)
  # end

  def best_offense

    game_teams = GameTeams.create_list_of_game_teams(@game_teams)
    game_averages_by_teams = {}
    game_teams.each do |game|
      game_averages_by_teams[game.team_id] = (game.goals.sum / game.goals.size)
      game_averages_by_teams << game if game.team_id == team_id
    end
    game_averages_by_teams.sort[-1]
  end

  # def worst_offense
  #   least_goal_average = average_goals_per_team.max_by do |key,value| value.first
  #     teams = GameTeams.create_list_of_game_teams(@game_teams).map { |team| team.team_id == team_id}
  #     end
  #   end
  # end
  #
  # def highest_scoring_visitor
  #   game_teams = GameTeams.create_list_of_game_teams(@game_teams)
  #   highest_goal_average_per_game = []
  #   game_teams.each do |game, team|
  #     team.each do goals.sum / goals.length
  #     highest_goal_average_per_game << team if team.hoa == "away"
  #     end
  #   end
  #   highest_goal_average_per_game.sort[-1]
  # end
  #
  # def highest_scoring_visitor
  #   game_teams = GameTeams.create_list_of_game_teams(@game_teams)
  #   highest_goal_average_per_game = []
  #   game_teams.each do |game, team|
  #     team.each do goals.sum / goals.length
  #     highest_goal_average_per_game << team if team.hoa == "home"
  #     end
  #   end
  #   highest_goal_average_per_game.sort[-1]
  # end
  #
  # def lowest_scoring_visitor
  #   game_teams = GameTeams.create_list_of_game_teams(@game_teams)
  #   highest_goal_average_per_game = []
  #   game_teams.each do |game, team|
  #     team.each do goals.sum / goals.length
  #     highest_goal_average_per_game << team if team.hoa == "away"
  #     end
  #   end
  #   highest_goal_average_per_game[0]
  # end
  #
  # def lowest_scoring_home_team
  #   game_teams = GameTeams.create_list_of_game_teams(@game_teams)
  #   games = game_teams.select { |game| game.team_id == team_id}
  #   home_team_average =[]
  #   average_score_per_game = games.each {|goals| goals.sum / goals.size}.to_f.round(2)
  #   home_team_average << average_score_per_game if hoa == "home"
  # end

end
