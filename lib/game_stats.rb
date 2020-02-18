require_relative 'game'
require_relative 'data_loadable'

class GameStats
  include DataLoadable
  attr_reader :games

  def initialize(file_path, object)
    @games = csv_data('./data/games_truncated.csv', Game)
  end
end
