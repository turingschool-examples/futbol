require_relative "stats"

class LeagueStats < Stats

  def count_of_teams
    @teams.length
  end

  def best_offense
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def worst_offense
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def highest_scoring_visitor
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def highest_scoring_home_team
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def lowest_scoring_visitor
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def lowest_scoring_home_team
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def average_goals_by_team(team_id, hoa = nil)
    goals = total_games_and_goals_by_team(team_id, hoa)[0]
    games = total_games_and_goals_by_team(team_id, hoa)[1]
    return 0 if games == 0
    average(goals, games)
  end

  def total_games_and_goals_by_team(team_id, hoa)
    goals_games = [0, 0]
    @game_teams.each do |game_team|
      if hoa && game_team.team_id == team_id && game_team.hoa == hoa
        add_goals_and_games(goals_games, game_team)
      elsif !hoa && game_team.team_id == team_id
        add_goals_and_games(goals_games, game_team)
      end
    end
    goals_games
  end

  def add_goals_and_games(goals_games, game_team)
    goals_games[0] += game_team.goals
    goals_games[1] += 1
  end

  def unique_team_ids
    @game_teams.map{|game_team| game_team.team_id}.uniq
  end

end
