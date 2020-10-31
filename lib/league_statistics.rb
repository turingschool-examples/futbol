require './lib/game_statistics'

class LeagueStatistics

  def count_of_teams(teams)
    teams.count
  end

  def best_offense(game_team_data,teams)
    team_name_from_id(teams,highest_goals_by_team_id(game_team_data))
  end

  def worst_offense(game_team_data,teams)
    team_name_from_id(teams,lowest_goals_by_team_id(game_team_data))
  end

  def highest_goals_by_team_id(game_team_data)
    total_goals_by_team(game_team_data).max_by do |team_id, goals_and_games|
      goal_to_shot_ratio(goals_and_games)
    end[0]
  end

  def lowest_goals_by_team_id(game_team_data)
    total_goals_by_team(game_team_data).min_by do |team_id, goals_and_games|
      goal_to_shot_ratio(goals_and_games)
    end[0]
  end

  def total_goals_by_team(game_team_data)
    goals_and_games = Hash.new {|hash, key| hash[key] = {
        goals: 0,
        games: 0
      }}
    game_team_data.each do |game_id, game_pair|
      game_pair.each do |hoa, game_obj|
        goals_and_games[game_obj.team_id][:goals] += game_obj.goals
        goals_and_games[game_obj.team_id][:games] += 1
        end
      end
     goals_and_games
  end

  def goal_to_shot_ratio(hash)
    hash[:goals].to_f / hash[:games]
  end

  def team_name_from_id(teams,id)
    teams[id.to_s].teamName
  end
end
