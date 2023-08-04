require './lib/stat_daddy'
require "csv"
require "pry"
require_relative "stat_daddy"

# binding.pry
class GameStats < StatDaddy


#   def initialize(locations)
#     @games = CSV.open(locations[:games], headers: true, header_converters: :symbol).map {|game| Game.new(game)}
#     # binding.pry
#   end


  def highest_total_score
    highest_total_score = 0

    @games.each do |data|
      away_goals = data.away_goals.to_i
      home_goals = data.home_goals.to_i
      score = away_goals + home_goals

      highest_total_score = score if score > highest_total_score
    end
    highest_total_score
  end

  def lowest_total_score
    # By assigning Float::INFINITY we ensure that with each encounter during the iteration we set the new lowest total score to the new found summed scores encountered in the data
    lowest_total_score = Float::INFINITY

    @games.each do |data|
      away_goals = data.away_goals.to_i
      home_goals = data.home_goals.to_i
      score = away_goals + home_goals

      lowest_total_score = score if score < lowest_total_score
    end
    lowest_total_score
  end

  def percentage_home_wins
    home_wins = 0 
    total_games = 0

    @games.each do |data|
      home_goals = data.home_goals.to_i
      away_goals = data.away_goals.to_i

      if home_goals > away_goals
        home_wins += 1
      end

      total_games += 1
    end

    home_win_percentage = (home_wins.to_f / total_games) * 100
    home_win_percentage.round(2)
  end

  def percentage_visitor_wins
    away_wins = 0 
    total_games = 0

    @games.each do |data|
      home_goals = data.home_goals.to_i
      away_goals = data.away_goals.to_i

      if away_goals > home_goals
        away_wins += 1
      end

      total_games += 1
    end

    away_win_percentage = (away_wins.to_f / total_games) * 100
    away_win_percentage.round(2)
  end

  def percentage_ties
    ties = 0
    total_games = 0
    
    @games.each do |data|
      home_goals = data.home_goals.to_i
      away_goals = data.away_goals.to_i

      if away_goals == home_goals
        ties += 1
      end

      total_games += 1
    end

    tie_percentage = (ties.to_f / total_games) * 100
    tie_percentage.round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @games.each do |data|
      season = @games[1]
      games_by_season.season += 1
    end

    games_by_season
  end

  def average_goals_per_game
    total_goals = 0
    total_games = @games.length

    @games.each do |data|
      home_goals = data.home_goals.to_i
      away_goals = data.away_goals.to_i
      total_goals += home_goals + away_goals
    end

    average_goals_per_game = (total_goals.to_f / total_games)
    average_goals_per_game.round(2)
  end

  def average_goals_by_season
  end
end
