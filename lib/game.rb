class Game
  attr_reader :date_time,
              :game_id
  def initialize(game)
    @game = game
    @date = game[:date_time]
    @game_id = game[:game_id]
  end
end