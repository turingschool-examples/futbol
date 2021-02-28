require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require 'mocha/minitest'

require './lib/team'
require './lib/team_manager'
require './lib/game'
require './lib/game_manager'
require './lib/game_stats'
require './lib/game_stats_manager'

require 'pry'
