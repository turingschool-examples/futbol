require_relative "game_data"
class GameStatistics

  def initialize
  end

  def all_games
    @all_games = GameData.create_objects
  end

end
