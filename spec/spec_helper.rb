require 'simplecov'
SimpleCov.start

require 'pry'
require 'rspec'
require './lib/game'
require './lib/gameteam'
require './lib/stat_tracker'
require './lib/team'

RSpec.configure do |config|
  config.formatter = :documentation
end
