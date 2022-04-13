require 'simplecov'
SimpleCov.start

require_relative 'stat_tracker_spec'
require_relative 'team_spec'
require_relative 'game_spec'
#makes a helper file to pull in existing spec file and now simplecov lives here

#spec/spec_helper - will run tests in required order in this file -> require them in this file to get the return in one big percentage
