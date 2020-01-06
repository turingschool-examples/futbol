class GameTeamsStats
  attr_reader :game_teams_collection

  def initialize(game_teams_collection)
    @game_teams_collection = game_teams_collection
  end

  def average_win_percentage(team_id)
    @game_teams_collection.total_wins_per_team / @game_teams_collection.total_games_per_team(team_id).to_f
  end

  def total_goals_by_team_id(team_id)
    @game_teams_collection.games_by_team_id(team_id).sum {|game_team| game_team.goals.to_i}
  end

  def average_goals_per_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f / @game_teams_collection.games_by_team_id(team_id).count)
  end

  def home_games_only_average
    home_only_average = {}
    @game_teams_collection.home_games_only.each do |game_id, games|
      home_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    home_only_average
  end

  def away_games_only_average
    away_only_average = {}
    @game_teams_collection.away_games_only.each do |game_id, games|
      away_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    away_only_average
  end

  def percentage(numerator, denominator) #to-do: make Calculatable module
    return ((numerator.to_f / denominator) * 100).round(2)
  end

  def team_win_percentage(games_hash, team, hoa = nil)
    team_games = Hash.new
    if hoa
      team_games[team] = games_hash[team].find_all { |game_team| game_team.hoa == hoa }
    else
      team_games[team] = games_hash[team]
    end
    wins = team_games[team].count { |game_team| game_team.result == "WIN" }
    percentage(wins, team_games[team].length)
  end

  def hoa_differences(all_games)
    diffs = Hash.new{}
    all_games.each do |key, value|
      diffs[key] = team_win_percentage(all_games, key, "home") - team_win_percentage(all_games, key, "away")
    end
    diffs
  end

end
