require 'csv'
require './lib/teams'
require './lib/games'

class Stats
  attr_reader :teams,
              :games
  
  def initialize(files)
    @teams = CSV.open(files[:teams], headers: true, header_converters: :symbol).map { |row| Teams.new(row) }
    @games = CSV.open(files[:games], headers: true, header_converters: :symbol).map { |row| Games.new(row) }
    @game_teams = CSV.open(files[:games], headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    
  end
end