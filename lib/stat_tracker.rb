require 'CSV'

class StatTracker

  def self.from_csv(locations)
    StatTracker.new
    @games = CSV.parse(File.read("./dummy_data/games_dummy.csv"), headers: true)
    @game_teams = CSV.parse(File.read("./dummy_data/game_teams_dummy.csv"), headers: true)
    @teams = CSV.parse(File.read("./dummy_data/teams_dummy.csv"), headers: true)
  end
end
