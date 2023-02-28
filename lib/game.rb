class Game
  attr_reader :games_data,
              :game_team_data

  def initialize(games_data, game_team_data)
    @games_data = games_data
    @game_team_data = game_team_data
  end
end