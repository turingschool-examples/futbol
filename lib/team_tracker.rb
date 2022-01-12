require './lib/data_collector'
require './lib/calculator'

class TeamTracker < Statistics
  include DataCollector

  def team_info(team_id)
    team_hash = {}
    get_team(team_id).instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      variable == 'stadium' ? next : team_hash[variable] = get_team(team_id).instance_variable_get("@#{variable}")
    end
    team_hash
  end


  def best_season(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = wins.to_f / win_hash[season].length
    end
    hash.key(hash.values.max)
  end

  def worst_season(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = wins.to_f / win_hash[season].length
    end
    hash.key(hash.values.min)
  end

  def average_win_percentage(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = (wins.to_f / win_hash[season].length).round(2)
    end
    ((hash.values.sum) / hash.values.length).round(2)
  end

  def most_goals_scored(team_id)
    team_goal_max = @game_teams.find_all do |game|
      game.team_id == team_id
    end
    game = team_goal_max.max_by do |game|
      game.goals
    end
    game.goals
  end

  def fewest_goals_scored(team_id)
    team_goal_min = @game_teams.find_all do |game|
      game.team_id == team_id
    end
    game = team_goal_min.min_by do |game|
      game.goals
    end
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
