require_relative 'csv_reader'
require_relative 'game_teams'

class GameStats < CSVReader
  def initialize(locations)
    super(locations)
  end

  def highest_total_score
    highest_sum = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

  def lowest_total_score
    lowest_sum = 0
    lowest = @games.map do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
    end
    lowest.min
  end

  def percentage_home_wins
    home_wins = []
    @game_teams.each do |game|
      if game.hoa == "home" && game.result == "WIN"
        home_wins << game
      end
     end
     (home_wins.length.to_f / @games.length.to_f).round(2)


  end

  def percentage_visitor_wins
    away_wins = []
    @game_teams.each do |game|
      if game.hoa == "away" && game.result == "WIN"
        away_wins << game
      end
     end
     (away_wins.length.to_f / @games.length.to_f).round(2)
     # require 'pry'; binding.pry
  end

  def percentage_ties
    # require 'pry'; binding.pry
    ((@game_teams.find_all { |game| game.result == 'TIE'}.count) / @game_teams.count.to_f).round(2)
  end

  def count_of_games_by_season
    # require 'pry'; binding.pry
    @games.group_by {|game| game.season}.transform_values { |values| values.count}
  end

  def average_goals_per_game
    avg_goals = []
    @games.each do |game|
      goals = game.away_goals + game.home_goals
      avg_goals << goals
    end
    (avg_goals.sum.to_f / avg_goals.length).round(2)
  end

  def average_goals_by_season
    avg_goals_hash = {}
    avg = @games.group_by {|game| game.season}
    avg.map { |season, games| games.map!{ |game| game.away_goals + game.home_goals } }
    avg.map { |season, games| avg_goals_hash[season] = (games.sum / games.length.to_f).round(2) }
    avg_goals_hash
  end

end
