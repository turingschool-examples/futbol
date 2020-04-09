class League

  def initialize

  end

  def count_of_teams
    Team.all_teams.count
  end

  def best_offense
    team_goal_totals = {}
    GameStats.all_game_stats.each do |game|
      if team_goal_totals[game.team_id] == nil
        team_goal_totals[game.team_id] = 0
      else
        team_goal_totals[game.team_id] += game.goals
      end
    end
    max_total = team_goal_totals.max_by do |keys, values|
        team_goal_totals[keys]
      end
      highest_team_id = max_total.first
      # require "pry"; binding.pry
      find_team_id(highest_team_id)

  end

  def find_team_id(id)
    found_team = Team.all_teams.find do |team|
      team.team_id == id
    end
    named_team = found_team.teamname
    named_team
    # require "pry"; binding.pry
  end

  def worst_offense
    team_goal_totals = {}
    GameStats.all_game_stats.each do |game|
      if team_goal_totals[game.team_id] == nil
        team_goal_totals[game.team_id] = 0
      else
        team_goal_totals[game.team_id] += game.goals
      end
    end
    min_total = team_goal_totals.min_by do |keys, values|
        team_goal_totals[keys]
      end
      lowest_team_id = min_total.first
      find_team_id(lowest_team_id)
  end

end
