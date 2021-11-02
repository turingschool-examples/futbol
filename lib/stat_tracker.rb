require 'csv'
require_relative './team'

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

    rows = CSV.read(locations[:games_teams], headers: true)
    rows.each do |row|
      games_teams = GamesTeams.new(row)
    end
  end
end
