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
    game_results = find_games(@games, game_team_results)
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

  def opponent_results(team_id, type)
    all_games = @games.find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id }
    game_teams_results = find_games(@game_teams, all_games)
    opponent_games = game_teams_results.find_all{|game| game.team_id != team_id}
    opponent_hash = opponent_games.reduce({}) do |hash, game|
      hash[game.team_id] = 0 unless hash.key?(game.team_id)
      hash[game.team_id] += 1 if game.result == "WIN" && type == "rival"
      hash[game.team_id] += 1 if game.result != "WIN" && type == "favorite"
      hash
    end
    opponent_hash.each {|k, v| opponent_hash[k] = v.to_f / count_games_per_team(k, opponent_games)}
    find_name_by_ID(opponent_hash.key(opponent_hash.values.max))[0].team_name
  end
end
