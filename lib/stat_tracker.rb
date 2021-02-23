require 'csv'
require 'smarter_csv'

class StatTracker 
  attr_reader :data
  
  def initialize
    @data = []
  end

  def self.from_csv(import_data)
    @data = import_data.map {|csv_file| SmarterCSV.process(csv_file[1])}
  end

end

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)


require 'pry'; binding.pry