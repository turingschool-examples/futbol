require './lib/game'
require 'csv'

class StatTracker
  def initialize(data)
    @games = data
    @teams = []
    @game_teams = []
  end

  def highest_total_score
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.max
  end

  def self.from_csv(locations)
      csv = CSV.readlines(locations, headers: true)
      data = csv.map do |line|
        Game.new(line[0],
                 line[1],
                 line[2],
                 line[3],
                 line[4],
                 line[5],
                 line[6],
                 line[7],
                 line[8],
                 line[9]
                )
              end
      new(data)
  end
end
