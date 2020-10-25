require 'csv'

class GameManager
  attr_reader :games_data_path,
              :games
  def initialize(file_locations)
    @games_data = file_locations[:games]
    @games = []
  end

  def all
    CSV.foreach(@games_data_path, headers: true, header_converters: :symbol) do |row|
      game_attributes = {
                          game_id: row[:game_id],
                          season: row[:season],
                          away_team_id: row[:away_team_id],
                          home_team_id: row[:home_team_id],
                          away_goals: row[:away_goals],
                          home_goals: row[:home_goals],
                        }
      @games << Game.new(game_attributes)
    end
    @games
  end
end
