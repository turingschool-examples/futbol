class StatTracker
  def self.from_csv(locations)
    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
    
    games = []
    teams = []
    game_teams = []
    CSV.foreach(locations[:games], headers: true) do |info|
        games << StatTracker.new(info)
    end
  end
    # def from_csv
end