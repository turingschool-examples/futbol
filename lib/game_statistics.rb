require 'csv'
require_relative 'game.rb'

class GameStatistics
  attr_reader :game

  def initialize(games)
    @games = games
  end

  def self.from_csv(filepath)
    games = []

    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]

      games << Games.new(game_id, away_team_id, home_team_id, away_goals, home_goals)
    end

    new(games)
  end

def highest_total_score
end

end
