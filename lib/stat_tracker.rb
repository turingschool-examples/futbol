<<<<<<< HEAD
require './lib/helper_class'
require_relative './helper_class'
=======
class StatTracker
  attr_reader :teams,
              :games,
              :game_teams

  def initialize
    @teams = []
    @games = []
    @game_teams = []
  end

  def self.from_csv()
  end
end
>>>>>>> 16301597386e3bfade7503a7e015fe0bb56f57cf
