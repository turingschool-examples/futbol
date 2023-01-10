# require_relative 'array_generator'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameRepo
  # include ArrayGenerator
  attr_reader :games

  def initialize(game_path)
    @games = Game.read_file(game_path[:game])
  end

#   def create_games_array(games_path)
#     games = []
#     CSV.foreach(games_path, headers: true, header_converters: :symbol) do |info|
#         games << Game.new(info)
#     end
#     games
# end


  def game_total_score
    # games.map { |game| game[:away_goals] + game[:home_goals] } 
    @away_goals + @home_goals
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