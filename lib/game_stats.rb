require "csv"
require_relative "./game"
require_relative "./season_groupable"
require_relative "./team_groupable"

class GameStats
  include SeasonGroupable
  include TeamGroupable

  attr_reader :games

  def initialize(games)
    @games = games
  end

  def self.from_csv(location)
    games = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    games_as_objects = games.map { |row| Game.new(row) }
    GameStats.new(games_as_objects)
  end

  def highest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.max
  end

  def lowest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.min
  end

  def percentage_home_wins
    ((@games.find_all { |game| game.home_goals.to_i > game.away_goals.to_i }.size) / (games.size).to_f).round(2)
  end

  def percentage_visitor_wins
    ((@games.find_all { |game| game.home_goals.to_i < game.away_goals.to_i }.size.to_f) / (games.size)).round(2)
  end

  def percentage_ties
    ((@games.find_all { |game| game.home_goals.to_i == game.away_goals.to_i }.size.to_f) / (games.size)).round(2)
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @games.each { |game| game_count[game.season] += 1 }
    game_count
  end

  def average_goals_per_game
    total_goals_per_game = []
    @games.map { |game| total_goals_per_game << [game.home_goals.to_i, game.away_goals.to_i].sum }
    ((total_goals_per_game.sum.to_f) / (@games.size)).round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    @games.map do |game|
      goals_by_season[game.season] += ((game.home_goals.to_i + game.away_goals.to_i))
    end
    goals_by_season.each do |season, total|
      goals_by_season[season] = (total / (season_grouper[season].count).to_f).round(2)
    end
    goals_by_season
  end

  def visitor_teams_average_score
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }
    away_team_scores.map do |id, scores|
      [id, ((scores.sum) / (scores.length)).round(2)]
    end
  end

  def home_teams_average_score
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }

    home_team_scores.map do |id, scores|
      [id, ((scores.sum) / (scores.length)).round(2)]
    end
  end

  def best_season(team_id) #we need a hash with each season as the keys and the win % for the season as the value
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the valueq
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / games.count).round(2)
      win_percent_hash[season] = win_percent
    end
    ranked_seasons = win_percent_hash.max_by { |season, win_percent| win_percent }
    ranked_seasons[0]
  end

  def worst_season(team_id)
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the value
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / games.count).round(2)
      win_percent_hash[season] = win_percent  #this is a hash with each season as the keys and the win % for the season as the value
    end
    ranked_seasons = win_percent_hash.min_by { |season, win_percent| win_percent }
    ranked_seasons[0]
  end
end