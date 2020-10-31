require_relative './game_statistics'

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
      goal_to_game_ratio(goals_and_games)
    end[0]
  end

  def lowest_goals_by_team_id(game_team_data)
    total_goals_by_team(game_team_data).min_by do |team_id, goals_and_games|
      goal_to_game_ratio(goals_and_games)
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

  def goal_to_game_ratio(hash)
    hash[:goals].to_f / hash[:games]
  end

  def highest_scoring_visitor(games,teams)
    team_name_from_id(teams,best_worst_offense_defense(games,true,"away"))
  end

  def highest_scoring_home_team(games,teams)
    team_name_from_id(teams,best_worst_offense_defense(games,true,"home"))
  end

  def lowest_scoring_visitor(games,teams)
    team_name_from_id(teams,best_worst_offense_defense(games,false,"away"))
  end

  def lowest_scoring_home_team(games,teams)
    team_name_from_id(teams,best_worst_offense_defense(games,false,"home"))
  end

  def best_worst_offense_defense(games,highest = true,hoa = "home")
    if highest
      hoa_goals_for_team(games,hoa).max_by do |team_id, goals_and_games|
        goal_to_game_ratio(goals_and_games)
      end[0]
    else
      hoa_goals_for_team(games,hoa).min_by do |team_id, goals_and_games|
        goal_to_game_ratio(goals_and_games)
      end[0]
    end
  end

  def hoa_goals_for_team(games,hoa)
    hoa_goals = Hash.new{|hash,key|hash[key] = {goals: 0, games: 0}}
    games.each do |game_id,game|
      if hoa == "home"
        hoa_goals[game.home_team_id][:goals] += game.home_goals
        hoa_goals[game.home_team_id][:games] += 1
      else
        hoa_goals[game.away_team_id][:goals] += game.away_goals
        hoa_goals[game.away_team_id][:games] += 1
      end
    end
    hoa_goals
  end

  def team_name_from_id(teams,id)
    teams[id.to_s].teamName
  end
end
