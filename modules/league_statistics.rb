require './lib/game_teams'
require './lib/team_stats'

module LeagueStats

  def count_of_teams
    teams = TeamStats.create_list_of_teams(@teams)
    teams.map { |team| team.length}
  end

  def best_offense
    game_teams = GameTeams.create_list_of_games(@game_teams)
    highest_goal_average_per_game = []
    game_teams.each do |game, team|
      team.each do goals.sum / goals.length
      highest_goal_average_per_game << team
      end
    end
    highest_goal_average_per_game.sort[-1]
  end

  def worst_offense
    game_teams = GameTeams.create_list_of_games(@game_teams)
    highest_goal_average_per_game = []
    game_teams.each do |game, team|
      team.each do goals.sum / goals.length
      highest_goal_average_per_game << team
      end
    end
    highest_goal_average_per_game[0]
  end

  def highest_scoring_visitor
    game_teams = GameTeams.create_list_of_games(@game_teams)
    highest_goal_average_per_game = []
    game_teams.each do |game, team|
      team.each do goals.sum / goals.length
      highest_goal_average_per_game << team if team.hoa == "away"
    end
    highest_goal_average_per_game.sort[-1]
  end




end
