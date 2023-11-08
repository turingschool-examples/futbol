require_relative './game_list'

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_list = GameList.new(locations[:games], self)
    require 'pry'; binding.pry
  end

  def highest_total_score
    @game_list.highest_total_score
  end
end