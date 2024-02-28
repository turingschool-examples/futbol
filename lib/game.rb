require 'CSV'

class Game
  attr_reader :game_id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game_data)
    @game_id = game_data[:game_id]
    @season = game_data[:season]
    @type = game_data[:type].to_s
    @away_team_id = game_data[:away_team_id]
    @home_team_id = game_data[:home_team_id]
    @away_goals = game_data[:away_goals]
    @home_goals = game_data[:home_goals]
  end

  def self.create_from_csv(file_path)
    games = []
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      game_data = {
        game_id: row["game_id"],
        season: row["season"],
        type: row["type"],
        away_team_id: row["away_team_id"],
        home_team_id: row["home_team_id"],
        away_goals: row["away_goals"],
        home_goals: row["home_goals"]
      }
    games << Game.new(game_data)
    end
    games
  end
end