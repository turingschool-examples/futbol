require 'csv'

class GameManager
  attr_reader :games_data_path,
              :games
  def initialize(data)
    @games_data_path = data
    @games = []
  end
end
