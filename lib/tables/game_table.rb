require './lib/helper_modules/csv_to_hashable.rb'
require './lib/instances/game'
class GameTable
  attr_reader :game_data, :stat_tracker
  include CsvToHash
  def initialize(locations, stat_tracker)
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
    #Average number of goals scored in a game organized in a hash with season
    #names (e.g. 20122013) as keys and a float representing the average number
    #of goals in a game for that season as values (rounded to the nearest 100th)

    games_by_season_hash = @game_data.group_by {|game| game.season.to_s}
    goals = games_by_season_hash.each do |season, game|
      games_by_season_hash[season] = game.away_goals + game.home_goals
    end
    goals
    require "pry"; binding.pry
  end

#     s1_count = games_by_season_hash[season].count
#     s1_total_goals = games_by_season_hash[season].flat_map {|game| game.away_goals + game.home_goals}
#     s1_average_goals_per_game = (s1_total_goals.sum.to_f / s1_count).round(2)
# require "pry"; binding.pry
#     # s2_count = games_by_season_hash[20162017].count
#     # s2_total_goals = games_by_season_hash[20162017].flat_map {|game| game.away_goals + game.home_goals}
#     # s2_average_goals_per_game = (s2_total_goals.sum.to_f / s2_count).round(2)
#     #
#     # s3_count = games_by_season_hash[20142015].count
#     # s3_total_goals = games_by_season_hash[20142015].flat_map {|game| game.away_goals + game.home_goals}
#     # s3_average_goals_per_game = (s3_total_goals.sum.to_f / s3_count).round(2)
#     #
#     # s4_count = games_by_season_hash[20152016].count
#     # s4_total_goals = games_by_season_hash[20152016].flat_map {|game| game.away_goals + game.home_goals}
#     # s4_average_goals_per_game = (s4_total_goals.sum.to_f / s4_count).round(2)
#     #
#     # s5_count = games_by_season_hash[20132014].count
#     # s5_total_goals = games_by_season_hash[20132014].flat_map {|game| game.away_goals + game.home_goals}
#     # s5_average_goals_per_game = (s5_total_goals.sum.to_f / s5_count).round(2)
#     #
#     # s6_count = games_by_season_hash[20172018].count
#     # s6_total_goals = games_by_season_hash[20172018].flat_map {|game| game.away_goals + game.home_goals}
#     # s6_average_goals_per_game = (s6_total_goals.sum.to_f / s6_count).round(2)
#     #
#
#     result = {
#       "20122013"=> s1_average_goals_per_game,
#       "20162017"=> s2_average_goals_per_game,
#       "20142015"=> s3_average_goals_per_game,
#       "20152016"=> s4_average_goals_per_game,
#       "20132014"=> s5_average_goals_per_game,
#       "20172018"=> s6_average_goals_per_game
#     }
#    end

  def game_by_season
    season = @game_data.group_by do |game|
      game.season
    end
  end
end
