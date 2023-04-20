require_relative 'stat_tracker'

class GameStats < StatTracker 
  def initialize(locations)
    super 
  end

  def highest_total_score
    require 'pry'; binding.pry
  end
end