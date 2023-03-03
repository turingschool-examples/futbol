require 'csv'

class Stats
  attr_reader :teams,
              :games,
              :game_teams
  
  def initialize(files)
    @teams = CSV.open(files[:teams], headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @games = CSV.open(files[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = CSV.open(files[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    
  end
end