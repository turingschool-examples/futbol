
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameRepo
  attr_reader :games

  def initialize(locations)
    @games = Game.read_file(locations[:games])
  end


  def game_total_score
    total_score = []
    @games.each do |game|
      total_score << game.away_goals + game.home_goals 
    end
    total_score
  end

  def home_wins
    total_home_wins = 0
    if @away_goals < @home_goals
        total_home_wins += 1
    end
  end

  def visitor_wins
    total_visitor_wins = 0
    if @away_goals > @home_goals
        total_visitor_wins += 1
    elsif @away_goals < @home_goals || @away_goals == @home_goals
        total_visitor_wins += 0
    end
  end

  def game_ties
    total_ties = 0
    if @away_goals == @home_goals
        total_ties += 1
    elsif @away_goals != @home_goals
        total_ties += 0
    end
  end
end