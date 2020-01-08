require './lib/game'
require './lib/game_team'

class Season

  attr_reader :season_games

  def initialize
    @season_games = season_games
  end

  def self.season_games
    require "pry"; binding.pry
  end
end
