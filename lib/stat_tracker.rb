require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(file_locations)
    @games = file_locations[:games]
    @teams = file_locations[:teams]
    @game_teams = file_locations[:game_teams]
  end

  def self.from_csv(data)
    StatTracker.new(data)
  end
end
