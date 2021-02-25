require 'pry'
require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "csv"
require "simplecov"

SimpleCov.start

require "./lib/game_team"
require "./lib/game"
require "./lib/league_statistics"
require "./lib/season_statistics"
require "./lib/stat_tracker"
require "./lib/team"


require "./manager/game_manager"
require "./manager/game_team_manager"
require "./manager/team_manager"
