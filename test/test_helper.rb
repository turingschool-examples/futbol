require 'pry'
require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "csv"
require "simplecov"

SimpleCov.start

require "./lib/game_statistics"
require "./lib/league_statistics"
require "./lib/season_statistics"
require "./lib/team_statistics"
