require "csv"

class StatTracker

  def initialize(stuff)
    @data = stuff
  end

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  def self.from_csv(locations)
    CSV.open(locations, headers: true, converters: :symbol) do |row|
      puts row
    end
  end
end
