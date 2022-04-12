require 'csv'
class StatTracker

  def self.from_csv(locations)
    games = CSV.open(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
    stat_tracker1 = self.new
    # require "pry";binding.pry
  end
end
