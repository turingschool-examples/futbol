require_relative 'game'
require_relative 'data_module'

class GameStats
  include DataLoadable

  def initialize(file_path)
    @games = csv_data('./data/games_truncated.csv')
  end
end
