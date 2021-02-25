require 'pry'
require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "csv"
require "simplecov"

SimpleCov.start

require "./lib/stat_tracker"
require "./lib/game_manager"
require "./lib/league_statistics"
require "./lib/season_statistics"
require "./lib/team_manager"
require "./lib/game_team_manager"
