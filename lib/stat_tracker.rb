require 'csv'
class StatTracker
  def initialize(file_name); end

  def self.from_csv(file_name)
    StatTracker.new(file_name)
  end

  StatTracker.from_csv({ games: './data/games.csv',
                         teams: './data/teams.csv',
                         game_teams: './data/game_teams.csv' })
end
