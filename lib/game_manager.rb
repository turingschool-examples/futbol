require_relative 'game'
require 'csv'

class GameManager
  attr_reader :games
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @games = generate_games(locations[:games])
    @av = {}
  end

  def return_max(hash)
    hash.key(hash.values.max)
  end

  def return_min(hash)
    hash.key(hash.values.min)
  end
end
