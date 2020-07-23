require_relative "game_data"
class GameStatistics
  attr_reader :all_games

  def initialize
    @all_games = GameData.create_objects
  end

end
