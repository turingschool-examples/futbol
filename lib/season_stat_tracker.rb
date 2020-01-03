require 'csv'
require_relative 'tracker'
require_relative './modules/calculateable'
require_relative './modules/gatherable'
require_relative './modules/season_stats'

class SeasonStatTracker < Tracker
  include Calculateable
  include Gatherable
  include SeasonStats
end
