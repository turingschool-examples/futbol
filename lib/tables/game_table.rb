require './lib/helper_modules/csv_to_hashable.rb'
require './lib/instances/game'
class GameTable
  attr_reader :game_data, :stat_tracker
  include CsvToHash
  def initialize(locations)
    @game_data = from_csv(locations, 'Game')
    @stat_tracker = stat_tracker
  end

  def other_call(data)
    data
  end

  def highest_total_score
    @game_data.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @game_data.map { |game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    wins = 0
    total = @game_data.map do |game|
      wins += 1 if game.home_goals > game.away_goals
    end
    total.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def percentage_away_wins
    wins = 0
    total = @game_data.map do |game|
      wins += 1 if game.home_goals < game.away_goals
    end
    total.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def percentage_ties
    wins = 0
    total = @game_data.map do |game|
      wins += 1 if game.home_goals == game.away_goals
    end
    total.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def count_of_games_by_season
    games_by_season_hash = @game_data.group_by {|game| game.season.to_s}
    result = games_by_season_hash.each do |season, games|
      games_by_season_hash[season] = games.count
    end
  end

  def average_goals_per_game
    total_games = @game_data.count
    total_goals = @game_data.flat_map {|game| game.away_goals + game.home_goals}
    average = (total_goals.sum.to_f / total_games).round(2)
  end

  def average_goals_by_season

    games_by_season_hash = @game_data.group_by {|game| game.season.to_s}


    goals = games_by_season_hash.each do |season, game|
      games_by_season_hash[season] = ((game.map {|indvidual_game| indvidual_game.away_goals.to_f + indvidual_game.home_goals.to_f}).sum/ game.count).round(2)

    end
    goals
  end

  def game_by_season
    season = @game_data.group_by do |game|
      game.season
    end
  end
  def favorite_opponent(results)
    away = results.map{|result| @game_data.find{|game| game.game_id == result[0]}.away_team_id}
    results = results.map{|result| @game_data.find{|game| game.game_id == result[0]}.home_team_id}.zip(away).zip(results)
    require 'pry'; binding.pry
  end
end

