require 'csv'
require_relative 'tracker'
require_relative './modules/calculateable'
require_relative './modules/gatherable'
require_relative './modules/team_stats'

class TeamStatTracker < Tracker
  include Calculateable
  include Gatherable
  include TeamStats
end
