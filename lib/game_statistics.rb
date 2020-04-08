# require './lib/stat_tracker'
require 'pry'


class GameStatistics
  attr_reader :stat_tracker
  def initialize(stats)
    @stat_tracker = stats
    binding.pry
  end


end
