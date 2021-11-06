require 'csv'
# require_relative 'pry'
require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './league'


class StatTracker
  attr_reader :league

  def initialize(locations)
    games = CSV.parse(File.read(locations[:games]), headers: true).map {|row| Game.new(row)}
    teams = CSV.parse(File.read(locations[:teams]), headers: true).map {|row| Team.new(row)}
    game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true).map {|row| GameTeam.new(row)}

    @league = League.new({games: games, teams: teams, game_teams: game_teams})
  end

  def self.from_csv(locations)
     StatTracker.new(locations)
   end


  def count_of_teams
    @league.count_of_teams
  end
end 
