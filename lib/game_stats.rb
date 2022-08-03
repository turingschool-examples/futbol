require "csv"
require_relative "./game"
require "./helpable"

class GameStats
  include Helpable

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

  def visitor_teams_average_score #needs test?
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }
    #could split these into two?
    away_team_scores.map do |id, scores|
      [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
    end
  end

  def home_teams_average_score #needs test?
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }
    #could split these into two?
    home_team_scores.map do |id, scores|
      [id, ((scores.sum) / (scores.length)).round(2)]
    end
  end

  def best_season(team_id) #we need a hash with each season as the keys and the win % for the season as the value
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the valueq
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      game_count = games.count
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / game_count).round(2)
      win_percent_hash[season] = win_percent
    end
    ranked_seasons = win_percent_hash.max_by do |season, win_percent|
      win_percent
    end
    ranked_seasons[0]
  end

  def worst_season(team_id)
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the value
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      game_count = games.count
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / game_count).round(2)
      win_percent_hash[season] = win_percent  #this is a hash with each season as the keys and the win % for the season as the value
    end
    ranked_seasons = win_percent_hash.min_by do |season, win_percent|
      win_percent
    end
    ranked_seasons[0]
  end

  def games_by_team_id_and_season(season) #needs test
    games_by_season = season_grouper[season] #season grouper is all games from the games csv grouped by season in arrays
    home_games = games_by_season.group_by { |game| game.home_team_id }
    away_games = games_by_season.group_by { |game| game.away_team_id }
    games_by_team_id =
      home_games.merge(away_games) { |team_id, home_game_array, away_game_array| home_game_array + away_game_array }
    #merged hash has 30 keys: each team's id. values are all games for a given season
  end

  def season_grouper #games helper, returns a hash with the season as the key and array of all games for the season as the value
    @games.group_by { |game| game.season }
  end

  def all_team_games(team_id) #games helper, returns all of a team's games in an array
    @games.find_all { |game| game.home_team_id == team_id || game.away_team_id == team_id }
  end

  def team_season_grouper(team_id) #helper, groups all of a team's games by season in a hash: the key is the season and the values are the team's games for that season
    all_games = all_team_games(team_id)
    all_games.group_by { |game| game.season }
  end

  def games_by_season(season_id) #helper method
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
        game_id_list << game.game_id
      end
    end
    game_id_list
  end
end
