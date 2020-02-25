require 'csv'
require_relative 'game_team_collection'
require_relative 'team'
require_relative 'game'



class TeamStat
  attr_reader :game_collection
  def initialize(game_file)
    @game_collection = GameCollection.new(game_file)

  end

  def highest_total_score
      max_sum = 0
      @game_collection.games_list.each do |game|
        sum = game.away_goals.to_i + game.home_goals.to_i
        if sum > max_sum
          max_sum = sum
        end
      end
      max_sum
  end

  def lowest_total_score
  min_sum = 0
  @game_collection.games_list.each do |game|
    sum = game.away_goals.to_i + game.home_goals.to_i
    if sum < min_sum
      min_sum = sum
    end
  end
    min_sum
  end

  def biggest_blowout
  highest_difference = 0
  @game_collection.games_list.each do |game|
    difference = (game.away_goals.to_i - game.home_goals.to_i).abs
    if difference > highest_difference
      highest_difference = difference
    end
  end
    highest_difference
  end

end
