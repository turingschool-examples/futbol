class GameStatistics
  attr_reader :game_id

  def initialize(hashed_game_data)
    @game_id = hashed_game_data
  end
end
