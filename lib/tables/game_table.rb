require './lib/helper_modules/csv_to_hashable.rb'
require './lib/instances/game'
class GameTable
  attr_reader :game_data, :stat_tracker
  include CsvToHash
  def initialize(locations)
    @game_data = from_csv(locations, 'Game')
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
    total = @game_data.map { |game| wins += 1 if game.home_goals > game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
    # require "pry"; binding.pry
    percentage
    end

  def percentage_away_wins
    wins = 0
    total = @game_data.map { |game| wins += 1 if game.home_goals < game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def percentage_ties
    wins = 0
    total = @game_data.map { |game| wins += 1 if game.home_goals == game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end
end
