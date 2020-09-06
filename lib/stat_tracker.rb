require 'csv'

class StatTracker

  attr_reader :games, :teams, :game_teams

  class << self
    self # => #<Class:StatTracker>

    def from_csv(locations)
      @games = StatTracker.new(locations[:games])
      @teams = StatTracker.new(locations[:teams])
      @game_teams = StatTracker.new(locations[:game_teams])
    end
  end

  def initialize(data)
    # table = CSV.new
    table = CSV.parse(File.read(data), headers: true)
  end
end
