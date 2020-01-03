require 'csv'
require_relative 'tracker'
require_relative './modules/league_stats'
require_relative './modules/game_stats'
require_relative './modules/season_stats'
require_relative './modules/team_stats'

class StatTracker < Tracker
  include LeagueStats
  include GameStats
  include SeasonStats
  include TeamStats
end
