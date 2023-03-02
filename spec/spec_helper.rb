require 'simplecov'
require 'csv'

SimpleCov.start

require 'rspec'
require '../lib/stat_tracker.rb'
# require '../lib/runner.rb'
require '../spec/stat_tracker_spec.rb'
require '../lib/game'
require './spec/team_spec.rb'
require './lib/team.rb'
require './lib/game_team.rb'
require './lib/season.rb'
