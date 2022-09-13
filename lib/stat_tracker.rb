require "csv"

class StatTracker
  attr_accessor :games_reader,
              :game_teams_reader,
              :teams_reader

  def initialize
    @teams_reader = nil
    @games_reader = nil
    @game_teams_reader = nil
  end

  def self.from_csv(locations)
    stat_tracker = new
    stat_tracker.teams_reader = CSV.read locations[:teams], headers: true, header_converters: :symbol
    stat_tracker.games_reader = CSV.read locations[:games], headers: true, header_converters: :symbol
    stat_tracker.games_teams_reader = CSV.read locations[:games_teams], headers: true, header_converters: :symbol
    stat_tracker
  end

  def count_of_teams
   counter = 0
   @teams_reader.each do |row|
    counter += 1
   end
   counter
  end
end

