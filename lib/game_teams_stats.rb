require_relative 'game_teams'
require_relative 'team_stats'
require_relative 'data_loadable'

class GameTeamStats
  include DataLoadable
  attr_reader :game_teams

  def initialize(file_path, object)
    @game_teams = csv_data(file_path, object)
    # not sure about this
    @team_stats = TeamStats.new("./data/teams.csv", Team)
  end

  def best_fans
    # home results
    home_games = @game_teams.select do |game_team|
      game_team.hoa == "home"
    end

    home_win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    home_games.each do |home_game|
      if home_game.result == "WIN"
        home_win_ratios[home_game.team_id][0] += 1
      end
        home_win_ratios[home_game.team_id][1] += 1
    end

    home_win_percentages = home_win_ratios.each_with_object(Hash.new) do |(team_id, home_win_ratio), home_win_percentages|
      home_win_percentages[team_id] = home_win_ratio[0].fdiv(home_win_ratio[1]) * 100
    end

    # away results
    away_games = @game_teams.select do |game_team|
      game_team.hoa == "away"
    end

    away_win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    away_games.each do |away_game|
      if away_game.result == "WIN"
        away_win_ratios[away_game.team_id][0] += 1
      end
        away_win_ratios[away_game.team_id][1] += 1
    end

    away_win_percentages = away_win_ratios.each_with_object(Hash.new) do |(team_id, away_win_ratio), away_win_percentages|
      away_win_percentages[team_id] = away_win_ratio[0].fdiv(away_win_ratio[1]) * 100
    end

    # list teams
    team_ids = (home_win_percentages.keys + away_win_percentages.keys).uniq

    # differences
    home_win_percentages.default = 0
    away_win_percentages.default = 0

    percent_differences = {}

    team_ids.each do |team_id|
      percent_differences[team_id] = home_win_percentages[team_id] - away_win_percentages[team_id]
    end

    team_id = percent_differences.key(percent_differences.values.max).to_i
    @team_stats.find_name(team_id)
  end

end
