require 'simplecov'
SimpleCov.start 
### Require your class files below here vvv ###
RSpec.configure do |config| 
    config.formatter = :documentation 
end
require 'pry'
require 'csv'

require './lib/game'
require './lib/team'
require './lib/season'
require './lib/stat_tracker'



