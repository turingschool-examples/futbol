require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.max
  end


  def lowest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.min
  end

  def percentage_home_wins
    (total_home_wins.to_f / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_away_wins.to_f / total_games.to_f).round(2)
  end

  def percentage_ties
    (total_ties.to_f / total_games.to_f).round(2)
  end

  def total_games
    @games.count
  end

  def total_home_wins
    home_wins = 0
    @games.each do |row|
      if row[:home_goals] > row[:away_goals]
        home_wins += 1
      end
    end
    home_wins
  end

  def total_home_losses
    home_losses = 0
    @games.each do |row|
      if row[:away_goals] > row[:home_goals]
        home_losses += 1
      end
    end
    home_losses
  end

  def total_ties
    total_ties = 0
    @games.each do |row|
      if row[:away_goals] == row[:home_goals]
        total_ties += 1
      end
    end
    total_ties
  end

  def total_away_losses
    total_home_wins
  end

  def total_away_wins
    total_home_losses
  end

  def count_of_games_by_season
    season = @games.map {|row| row[:season]}
    season.tally
  end

  def average_goals_per_game
    goals = @games.map {|row| row[:away_goals].to_f + row[:home_goals].to_f}
    goals = goals.sum
    (goals / total_games).round(2)
  end

  def average_goals_by_season
    hash = Hash.new(0)
    @games.map do |row|
      goals = row[:away_goals].to_f + row[:home_goals].to_f
      season = row[:season]
      hash[season] += goals
    end

    nested_arr = count_of_games_by_season.values.zip(hash.values)
    arr = nested_arr.map {|array| (array[1] / array[0]).round(2)}
    avg = Hash[count_of_games_by_season.keys.zip(arr)]
  end

  def count_of_teams
    @teams.count
  end

  def average_goals
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      team_id = row[:team_id]
      goals = row[:goals].to_f
      team_goals[team_id] += goals
    end
    team_game = @game_teams.map {|row| row[:team_id]}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    avg = Hash[team_game.keys.zip(arr)]
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

  def most_goals_scored(team_id)
    most_goals = []
    @game_teams.map do |row|
      if row[:team_id] == team_id
        most_goals << row[:goals]
      end
    end
    most_goals.max.to_i
  end

  def fewest_goals_scored(team_id)
    fewest_goals = []
    @game_teams.map do |row|
      if row[:team_id] == team_id
        fewest_goals << row[:goals]
      end
    end
    fewest_goals.min.to_i
  end

  def total_times_won_against(team_id)
    teams_win_count = Hash.new(0)
    @games.map do |row|
      if row[:away_team_id] == team_id && row[:away_goals] < row[:home_goals]
        teams_win_count[row[:home_team_id]] += 1
      elsif row[:home_team_id] == team_id && row[:home_goals] < row[:away_goals]
        teams_win_count[row[:away_team_id]] += 1
      end
    end
    teams_win_count
  end

  def total_times_played_against(team_id)
    total_times_played = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id
        total_times_played[row[:away_team_id]] += 1
      elsif row[:away_team_id] == team_id
        total_times_played[row[:home_team_id]] += 1
      end
    end
    total_times_played
  end

  def favorite_opponent(team_id)
    wins = total_times_won_against(team_id)
    total_games = total_times_played_against(team_id)

    wins_and_totals = wins.values.zip(total_games.values)
    percentage_wins = wins_and_totals.map {|array| array[0].to_f / array[1]}

    hash_percentages = Hash[wins.keys.zip(percentage_wins)]

    # nested_arr = total_wins_hash.values.zip(total_games_played_against_team.values)
    # percentages = nested_arr.map {|array| array[0].to_f / array [1]}
    # percentages_hash = total_games_played_against_team.keys.zip(percentages)
    # lost_most = percentages_hash.min_by {|key,value| value}
    # fav_oppt = team_name(lost_most[0].to_i)
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
end