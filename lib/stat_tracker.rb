require 'csv'
require_relative './team'
require_relative './game_teams'
require_relative './games'

class StatTracker
  # attr_reader

  def initialize()

  end

  def self.from_csv(locations)
    rows = CSV.read(locations[:teams], headers: true)
    rows.each do |row|
      team = Team.new(row)
    end

    rows = CSV.read(locations[:games], headers: true)
    rows.each do |row|
      games = Games.new(row)
    end

    rows = CSV.read(locations[:game_teams], headers: true)
    rows.each do |row|
      game_teams = GameTeams.new(row)
    end
  end
end
