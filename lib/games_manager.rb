require_relative './game'

class GamesManager
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Game.new(row)
    end
    list_of_data
  end

  def home_and_away_goals_sum
    games.map {|game| game.total_goals} # #delegated to game.rb
  end

  def highest_total_score
    home_and_away_goals_sum.max
  end

  def lowest_total_score
    home_and_away_goals_sum.min
  end

  def percentage_home_wins
    wins = games.count {|game| game.away_goals < game.home_goals}
    to_percent(wins, games.size)
  end

  def percentage_visitor_wins
    wins = games.count {|game| game.away_goals > game.home_goals}
    to_percent(wins, games.size)
  end

  def percentage_ties
    ties = games.count {|game| game.away_goals == game.home_goals}
    to_percent(ties, games.size)
  end

  def count_of_games_by_season
    games_in_season = Hash.new(0)
    games.each {|game| games_in_season[game.season] += 1}
    games_in_season
  end

  def average_goals_per_game
    total_goals = games.sum {|game| game.total_goals}
    to_percent(total_goals, games.size)
  end

  def average_goals_by_season
    goals_in_season = Hash.new(0)
    games.each {|game| goals_in_season[game.season] += game.total_goals}
    count_of_games_by_season.merge(goals_in_season) do |season, games, goals|
      to_percent(goals, games)
    end
  end

  def get_season_results(team_id)
    summary = {}
    @games.each do |game|
      if game.home_team?(team_id) || game.away_team?(team_id)
        summary[game.season] ||= []  ##sugar - if summary[game.season].nil?
        result = "non-win"
        result = "W" if game.won?(team_id)  ##delegated to game.rb
        summary[game.season] << result
      end
    end
    summary
  end

  def best_season(team_id)
    get_season_results(team_id).max_by do |k, v|
      v.count('W').to_f / v.size
    end.first
  end

  def worst_season(team_id)
    get_season_results(team_id).min_by do |k, v|
      v.count('W').to_f / v.size
    end.first
  end

  def average_win_percentage(team_id)
    wins = all = 0
    get_season_results(team_id).each do |key, value|
      wins += value.count("W")
      all += value.size
    end
    to_percent(wins, all)
  end

  def get_goals_scored(team_id)
    scored = []
    @games.each do |game|
      scored << game.home_goals if game.home_team?(team_id)
      scored << game.away_goals if game.away_team?(team_id)
    end
    scored
  end

  def most_goals_scored(team_id)
    get_goals_scored(team_id).max_by {|score| score}
  end

  def fewest_goals_scored(team_id)
    get_goals_scored(team_id).min_by {|score| score}
  end

  def get_season_games(season)
    season_games = @games.find_all do |game|
      game.season == season
    end
    season_games.map {|game| game.game_id}
  end

  def total_home_goals
    team_id_by_home_goals = games.map do |game|
      [game.home_team_id, game.home_goals]
    end
    sum_values(team_id_by_home_goals)
  end

  def total_away_goals
    team_id_by_away_goals = games.map do |game|
      [game.away_team_id, game.away_goals]
    end
    sum_values(team_id_by_away_goals)
  end

  def total_home_games
    home_games_by_team = games.map {|game| [game.home_team_id, 1]}
    sum_values(home_games_by_team)
  end

  def total_away_games
    away_games_by_team = games.map {|game| [game.away_team_id, 1]}
    sum_values(away_games_by_team)
  end

  def sum_values(key_value_arr)
    sum = Hash.new(0)
    key_value_arr.each {|key, value| sum[key] += value}
    sum
  end

  def highest_scoring_visitor
    max_average_hash_values(total_away_goals, total_away_games)
  end

  def lowest_scoring_visitor
    min_average_hash_values(total_away_goals, total_away_games)
  end

  def highest_scoring_home
    max_average_hash_values(total_home_goals, total_home_games)
  end

  def lowest_scoring_home
    min_average_hash_values(total_home_goals, total_home_games)
  end

  def min_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      to_percent(hash_1_value, hash_2_value)
    end
    (averages.min_by {|team_id, average| average})[0]
  end

  def max_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      to_percent(hash_1_value, hash_2_value)
    end
    (averages.max_by {|team_id, average| average})[0]
  end

  def to_percent(top, bottom)
    (top.to_f / bottom).round(2)
  end
end
