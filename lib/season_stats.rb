require 'csv'
require 'team'

class SeasonStats
  
  def initialize
    @teams = CSV.open('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @game_teams = CSV.open('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
  end

  
end