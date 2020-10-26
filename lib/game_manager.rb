require 'csv'

class GameManager
  attr_reader :games_data_path,
              :games
  def initialize(file_locations)
    @games_data = file_locations[:games]
    @games = []
  end

  def all
    CSV.foreach(@games_data, headers: true, header_converters: :symbol) do |row|
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

  def highest_total_score
    most_goals = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    most_goals.away_goals + most_goals.home_goals
  end

  def lowest_total_score
    least_goals = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    least_goals.away_goals + least_goals.home_goals
  end

end
