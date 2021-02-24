require 'CSV'

class StatTracker

  def self.from_csv(locations)
    StatTracker.new
    @games = CSV.parse(File.read(locations[:games]), headers: true)
    @game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true)
    @teams = CSV.parse(File.read(locations[:teams]), headers: true)
  end
end
