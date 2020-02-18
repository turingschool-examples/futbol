require_relative 'game'
require_relative 'data_loadable'

class GameStats
  include DataLoadable
  attr_reader :games

  def initialize(file_path, object)
    @games = csv_data('./data/games_truncated.csv', Game)
  end

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def biggest_blowout
    @games.map {|game| (game.away_goals - game.home_goals).abs}.max
  end
end
