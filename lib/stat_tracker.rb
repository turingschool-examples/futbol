require 'csv'
require 'games'

class StatTracker
  attr_reader :locations, :data

  def initialize(locations)
    @locations = locations
    @data = {}
    locations.each_key do |key|
      data[key] = CSV.read locations[key]
    end
    # games = Games.new(locations[:games])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score

  end
end
