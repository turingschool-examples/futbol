require 'csv'
require_relative './game_teams.rb'
require './helpable'

class GameTeamsStats
  include Helpable
  
  attr_reader :game_teams

  def initialize(game_teams)
    @game_teams = game_teams
  end

  def self.from_csv(location)
    game_teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams_as_objects = game_teams.map { |row| GameTeams.new(row) }
    GameTeamsStats.new(game_teams_as_objects)
  end


end