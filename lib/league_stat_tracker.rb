require 'csv'
require_relative 'tracker'
require_relative './modules/calculateable'
require_relative './modules/gatherable'
require_relative './modules/league_stats'

class LeagueStatTracker < Tracker
  include Calculateable
  include Gatherable
  include LeagueStats
end
