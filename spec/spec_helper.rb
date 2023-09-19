require "simplecov"
SimpleCov.start do
  enable_coverage :branch
  add_filter "/spec/"
  add_filter "/data/"
end

require "rspec"
require "csv"
require "./lib/stat_tracker"

