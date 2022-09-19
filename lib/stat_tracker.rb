require 'csv'
require_relative 'team_stats'
require_relative 'game_stats'

class StatTracker
  include TeamStatistics
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read locations[:games], headers: true, header_converters: :symbol
    teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    StatTracker.new(games, teams, game_teams)
  end

  def team_name(team_id)
    name = @teams.filter_map {|row| row[:teamname] if row[:team_id].to_i == team_id }
    return name[0]
  end

  def best_offense
    best = average_goals.max_by {|key,value| value}
    hash = Hash.new
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      hash[team_id] = team_name
    end
    num1 = hash.filter_map {|key,value| value if key == best[0] }
    num1[0]
  end

  def worst_offense
    worst = average_goals.min_by {|key,value| value}
    hash = Hash.new
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      hash[team_id] = team_name
    end
    the_worst = hash.filter_map {|key,value| value if key == worst[0] }
    the_worst[0]
  end

  def highest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'away'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'away'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    away_avg = Hash[team_game.keys.zip(arr)]
    best_away = away_avg.max_by {|key,value| value}
    team_name(best_away[0].to_i)
  end

  def highest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'home'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'home'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    home_avg = Hash[team_game.keys.zip(arr)]
    best_home = home_avg.max_by {|key,value| value}
    team_name(best_home[0].to_i)
  end

  def lowest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'away'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'away'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    away_avg = Hash[team_game.keys.zip(arr)]
    best_away = away_avg.min_by {|key,value| value}
    team_name(best_away[0].to_i)
  end

  def lowest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'home'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'home'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    home_avg = Hash[team_game.keys.zip(arr)]
    best_home = home_avg.min_by {|key,value| value}
    team_name(best_home[0].to_i)
  end

  def team_info(team_id)
    team_hash = Hash.new
    @teams.map do |row|
      if row[:team_id] == team_id
        team_hash["team_id"] = row[:team_id]
        team_hash["franchise_id"] = row[:franchiseid]
        team_hash["team_name"] = row[:teamname]
        team_hash["abbreviation"] = row[:abbreviation]
        team_hash["link"] = row[:link]
      end
    end
    team_hash
  end

  def total_wins_per_season(team_id)
    season_wins = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id && row[:home_goals] > row[:away_goals]
        season_wins[row[:season]] += 1
      elsif row[:away_team_id] == team_id && row[:away_goals] > row[:home_goals]
        season_wins[row[:season]] += 1
      end
    end
    season_wins
  end

  def total_games_played_per_season(team_id)
    season_tally = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id || row[:away_team_id] == team_id
        season_tally[row[:season]] += 1
      end
    end
    season_tally
  end

  def best_season(team_id)
    season_wins = total_wins_per_season(team_id)
    games_played = total_games_played_per_season(team_id)

    nested_arr = season_wins.values.zip(games_played.values)
    divide_wins_to_games = nested_arr.map {|array| array[0].to_f / array[1]}
    percentages_hash = Hash[games_played.keys.zip(divide_wins_to_games)]
    best = percentages_hash.max_by {|key,value| value}
    best[0]
  end

  def worst_season(team_id)
    season_wins = total_wins_per_season(team_id)
    games_played = total_games_played_per_season(team_id)

    nested_arr = season_wins.values.zip(games_played.values)
    divide_wins_to_games = nested_arr.map {|array| array[0].to_f / array[1]}
    percentages_hash = Hash[games_played.keys.zip(divide_wins_to_games)]
    best = percentages_hash.min_by {|key,value| value}
    best[0]
  end

  def total_games_played(team_id)
    all_games = 0
    @games.filter_map {|row| all_games += 1 if row[:home_team_id] == team_id || row[:away_team_id] == team_id}
    all_games
  end

  def average_win_percentage(team_id)
    total_wins = total_wins_per_season(team_id).values.sum.to_f
    (total_wins / total_games_played(team_id)).round(2)
  end

  def most_tackles(season)
    tackles_hash = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3]
        tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end
    most = tackles_hash.max_by {|team_id, tackles| tackles}
    team_name(most[0].to_i)
  end

  def fewest_tackles(season)
    tackles_hash = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3]
        tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end
    least = tackles_hash.min_by {|team_id, tackles| tackles}
    team_name(least[0].to_i)
  end

  def total_games_played_per_team(season)
    game_tally = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3]
        game_tally[row[:head_coach]] += 1
      end
    end
    game_tally
  end

  def total_wins_per_team(season)
    team_wins_hash = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3] && row[:result] == "WIN"
        team_wins_hash[row[:head_coach]] += 1
      end
    end
    team_wins_hash
  end

  def winningest_coach(season)
    team_season_wins = total_wins_per_team(season)
    team_total_season_games = total_games_played_per_team(season)
    missing_coaches = team_total_season_games.keys - team_season_wins.keys
    act_total_wins = missing_coaches.map do |coach|
      team_season_wins[coach] = 0
    end
    team_season_wins = team_season_wins.sort.to_h
    team_total_season_games = team_total_season_games.sort.to_h
    nested_arr = team_season_wins.values.zip(team_total_season_games.values)
    win_percent = nested_arr.map do |array|
      array[0].to_f / array[1]
    end
    win_percent_hash = Hash[team_total_season_games.keys.zip(win_percent)]
    winningest = win_percent_hash.max_by {|key, value| value}
    winningest[0].to_s
  end

  def worst_coach(season)
    team_season_wins = total_wins_per_team(season)
    team_total_season_games = total_games_played_per_team(season)
    missing_coaches = team_total_season_games.keys - team_season_wins.keys
    act_total_wins = missing_coaches.map do |coach|
      team_season_wins[coach] = 0
    end
    team_season_wins = team_season_wins.sort.to_h
    team_total_season_games = team_total_season_games.sort.to_h
    nested_arr = team_season_wins.values.zip(team_total_season_games.values)
      win_percent = nested_arr.map do |array|
        array[0].to_f / array[1]
      end
    win_percent_hash = Hash[team_total_season_games.keys.zip(win_percent)]
    worst = win_percent_hash.min_by {|key, value| value}
    worst[0].to_s
  end

  def find_season(season_id)
    games = []
    @game_teams.each do |row|
      games << row if row[:game_id][0, 4] == season_id[0,4]
    end
    games
  end

  def total_goals(season_id)
    t_goals = Hash.new(0)
    self.find_season(season_id).each do |row|
      if !t_goals.key?(row[:team_id])
        t_goals[row[:team_id]] = row[:goals].to_f
      else
        t_goals[row[:team_id]] += row[:goals].to_f
      end
    end
    t_goals
  end

  def total_shots(season_id)
    t_shots = Hash.new(0)
    self.find_season(season_id).each do |row|
      if !t_shots.key?(row[:team_id])
        t_shots[row[:team_id]] = row[:shots].to_f
      else
        t_shots[row[:team_id]] += row[:shots].to_f
      end
    end
    t_shots
  end

  def most_accurate_team(season_id)
    total_shots = total_shots(season_id)
    total_goals = total_goals(season_id)

    shots_and_goals = total_shots.values.zip(total_goals.values)
    shots_to_goals_ratio = shots_and_goals.map {|array| array[1] / array[0]}

    ratio_hash = Hash[total_shots.keys.zip(shots_to_goals_ratio)]
    most_accurate = ratio_hash.max_by {|team_id, ratio| ratio}
    team_name(most_accurate[0].to_i)
  end

  def least_accurate_team(season_id)
    total_shots = total_shots(season_id)
    total_goals = total_goals(season_id)

    shots_and_goals = total_shots.values.zip(total_goals.values)
    shots_to_goals_ratio = shots_and_goals.map {|array| array[1] / array[0]}

    ratio_hash = Hash[total_shots.keys.zip(shots_to_goals_ratio)]
    most_accurate = ratio_hash.min_by {|team_id, ratio| ratio}
    team_name(most_accurate[0].to_i)
  end
end
