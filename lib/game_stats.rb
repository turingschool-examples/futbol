class GameStats
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def percentage_home_wins
    home_wins = 0 
    @games.each do |game|
      if game[:home_goals] > game[:away_goals]
        home_wins += 1
      end
    end
    home_wins / @games.count * 100
  end
  require 'pry'; binding.pry





end