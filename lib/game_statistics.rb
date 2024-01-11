require 'csv'
require_relative 'game.rb'

class GameStatistics
  attr_reader :games

  def initialize
    @games = []
  end

  def create_game_stats(filepath)
    @games

    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]

      @games << Game.new(row)
    end

    @games 
  end

  def highest_total_score
    highest_score = 0
    @games.each do |game| 
      total_score = game.home_goals + game.away_goals 
      highest_score = total_score if total_score > highest_score
    end
    highest_score
  end

  def lowest_total_score
    lowest_score = Float::INFINITY
    @games.each do |game| 
      total_score = game.home_goals + game.away_goals 
      lowest_score = total_score if total_score < lowest_score
    end
    lowest_score == Float::INFINITY ? 0 : lowest_score
  end 

  def percentage_home_wins 
    total_games = @games.size 
    home_wins = @games.count {|game| game.home_goals > game.away_goals}
    (home_wins.to_f / total_games * 100).round(2)
  end

  def percentage_away_wins
    total_games = @games.size 
    away_wins = @games.count {|game| game.away_goals > game.home_goals}
    (away_wins.to_f / total_games * 100).round(2)
  end
end
