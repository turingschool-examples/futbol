require 'csv'

class GamesStats

  def initialize
    @games = CSV.open('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  def highest_total_score
    high_score = @games.max_by{ |game| game.total_score }
    high_score.total_score
  end
###this can be refactored with &: stuff### ^ \/
  def lowest_total_score
    low_score = @games.min_by{ |game| game.total_score }
    low_score.total_score
  end

  def percentage_home_wins
    ###this can definitely be refactored###
    home_wins = []
    @games.each do |game|
      if game.home_goals.to_i > game.away_goals.to_i
        home_wins << game
      end
    end
    home_percent_wins = home_wins.length.fdiv(@games.length).round(2)
  end

  def percentage_visitor_wins
    ###this can definitely be refactored###
    away_wins = []
    @games.each do |game|
      if game.away_goals.to_i > game.home_goals.to_i
        away_wins << game
      end
    end
    away_percent_wins = away_wins.length.fdiv(@games.length).round(2)
  end

end