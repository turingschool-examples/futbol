# require "./lib/stattracker.rb"
require "csv"

lines = File.readlines'./data/games_fixture.csv'
lines.each do |line|
  puts line
end

class GameStats

  # Highest sum of the winning and losing teams’ scores	Return Value: Integer
  def highest_total_score 
  end

  def lowest_total_score
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end
end