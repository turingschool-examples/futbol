require './lib/data_collector'
require './lib/calculator'

class TeamTracker < Statistics
  include DataCollector
  include Calculator

  def team_info(team_id)
    team_hash = {}
    get_team(team_id).instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      variable == 'stadium' ? next : team_hash[variable] = get_team(team_id).instance_variable_get("@#{variable}")
    end
    team_hash
  end

  def season_outcome(team_id, outcome)
    game_team_results = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"} if outcome == "best"
    game_team_results = @game_teams.find_all {|game| game.team_id == team_id && game.result != "WIN"} if outcome == "worse"
    game_results = find_games(game_team_results)
    games_by_season = game_results.group_by {|game| game.season}
    averaged_results = games_by_season.reduce({}) do |hash, season_games|
      hash[season_games[0]] = season_games[1].length
      hash
    end
    averaged_results.key(averaged_results.values.max)
  end

  def average_win_percentage(team_id)
    games_by_team = @game_teams.find_all {|game| game.team_id == team_id}
    total_wins = games_by_team.count do |game|
      game.result == "WIN"
    end
    average(total_wins, games_by_team)
  end

  def goals_scored(team_id, amount)
    team_goal_max = @game_teams.find_all {|game| game.team_id == team_id}
    game = team_goal_max.max_by {|game| game.goals} if amount == 'most'
    game = team_goal_max.min_by {|game| game.goals} if amount == 'fewest'
    game.goals
  end

  def favorite_opponent(team_id)
    all_games = @games.find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id }
    opponent_lost_hash = Hash.new { |hash, key| hash[key] = [] }
    total_opponent_games = Hash.new { |hash, key| hash[key] = 0 }
    all_games.each do |game|
      opponent_lost_hash[game.away_team_id] << game if (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
      opponent_lost_hash[game.home_team_id] << game if (game.away_team_id == team_id) && (game.home_goals < game.away_goals)
      total_opponent_games[game.home_team_id] += 1 if (game.away_team_id == team_id)
      total_opponent_games[game.away_team_id] += 1 if (game.home_team_id == team_id)
    end
    most_win_hash = Hash.new
    opponent_lost_hash.each_pair do |lost_opponent, won_games|
      total_opponent_games.each_pair do |any_opponent, all_games|
        if lost_opponent == any_opponent
          most_win_hash[lost_opponent] = won_games.length / all_games.to_f
        end
      end
    end
    find_name_by_ID(most_win_hash.key(most_win_hash.values.max))[0].team_name
  end

  def rival(team_id) ###REFACTOR VARIABLE NAMES
    all_games = @games.find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id }
    opponent_lost_hash = Hash.new { |hash, key| hash[key] = [] }
    total_opponent_games = Hash.new { |hash, key| hash[key] = 0 }
    all_games.each do |game|
      opponent_lost_hash[game.away_team_id] << game if (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
      opponent_lost_hash[game.home_team_id] << game if (game.away_team_id == team_id) && (game.home_goals < game.away_goals)
      total_opponent_games[game.home_team_id] += 1 if (game.away_team_id == team_id)
      total_opponent_games[game.away_team_id] += 1 if (game.home_team_id == team_id)
    end
    most_win_hash = Hash.new
    opponent_lost_hash.each_pair do |lost_opponent, won_games|
      total_opponent_games.each_pair do |any_opponent, all_games|
        if lost_opponent == any_opponent
          most_win_hash[lost_opponent] = won_games.length / all_games.to_f
        end
      end
    end
    find_name_by_ID(most_win_hash.key(most_win_hash.values.min))[0].team_name
  end
end
