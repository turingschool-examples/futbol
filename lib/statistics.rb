require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_team'

class Statistics
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map {|row| Game.new(row)}
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeam.new(row)}
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map {|row| Team.new(row)}
  end

  def find_name_by_ID(name_id)
    @teams.select do |team|
      team.team_id == name_id
    end
  end
end


#
