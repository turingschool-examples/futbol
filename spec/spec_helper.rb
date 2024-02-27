require 'simplecov'
require 'pry'
require '../lib/game'
require '../lib/gameteam'
require '../lib/stat_tracker'
require '../lib/team'

RSpec.configure do |config|
  config.formatter = :documentation
end
SimpleCov.start

# Previous content of test helper now starts here