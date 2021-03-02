require_relative './readable'
require_relative './mathable'
require_relative './game'

class GamesManager
  include Readable
  include Mathable
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path, Game)
  end

  def highest_total_score
    (games.map { |game| game.total_goals }).max
  end

  def lowest_total_score
    (games.map { |game| game.total_goals }).min
  end

  def percentage_home_wins
    wins = games.count {|game| game.away_goals < game.home_goals}
    get_percentage(wins, games.count)
  end

  def percentage_visitor_wins
    wins = games.count {|game| game.away_goals > game.home_goals}
    get_percentage(wins, games.size)
  end

  def percentage_ties
    ties = games.count {|game| game.away_goals == game.home_goals}
    get_percentage(ties, games.size)
  end

  def count_of_games_by_season
    games_in_season = Hash.new(0)
    games.each {|game| games_in_season[game.season] += 1}
    games_in_season
  end

  def average_goals_per_game
    total_goals = games.sum {|game| game.total_goals}
    get_percentage(total_goals, games.size)
  end

  def average_goals_by_season
    goals_in_season = Hash.new(0)
    games.each {|game| goals_in_season[game.season] += game.total_goals}
    count_of_games_by_season.merge(goals_in_season) do |season, games, goals|
      get_percentage(goals, games)
    end
  end

  def get_season_results(team_id)
    summary = {}
    @games.each do |game|
      if game.home_team?(team_id) || game.away_team?(team_id)
        summary[game.season] ||= []
        result = "non-win"
        result = "WIN" if game.won?(team_id)
        summary[game.season] << result
      end
    end
    summary
  end

  def best_season(team_id)
    rando = get_season_results(team_id).max_by do |key, value|
      value.count('WIN').to_f / value.size
    end.first
  end

  def worst_season(team_id)
    get_season_results(team_id).min_by do |key, value|
      value.count('WIN').to_f / value.size
    end.first
  end

  def average_win_percentage(team_id)
    wins = 0
    all = 0
    get_season_results(team_id).each do |key, value|
      wins += value.count("WIN")
      all += value.count
    end
    get_percentage(wins, all)
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
    get_goals_scored(team_id).max_by { |score|score }
  end

  def fewest_goals_scored(team_id)
    get_goals_scored(team_id).min_by { |score| score }
  end

  def get_season_games(season)
    season_games = @games.find_all { |game| game.season == season }
    season_games.map { |game| game.game_id }
  end

  def total_home_goals
    home_goals = games.map { |game| [game.home_team_id, game.home_goals] }
    sum_values(home_goals)
  end

  def total_away_goals
    away_goals = games.map { |game| [game.away_team_id, game.away_goals] }
    sum_values(away_goals)
  end

  def total_home_games
    team_home_games = games.map { |game| [game.home_team_id, 1] }
    sum_values(team_home_games)
  end

  def total_away_games
    team_away_games = games.map { |game| [game.away_team_id, 1] }
    sum_values(team_away_games)
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
end
