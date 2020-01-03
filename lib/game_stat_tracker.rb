require 'csv'
require_relative 'tracker'
require_relative './modules/calculateable'
require_relative './modules/gatherable'
require_relative './modules/game_stats'

class GameStatTracker < Tracker
  include Calculateable
  include Gatherable
  include GameStats
end
