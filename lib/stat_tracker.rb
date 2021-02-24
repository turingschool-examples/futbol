require 'csv'
require './lib/team_module'
require './lib/game_team'
require './lib/game_statistics'

class StatTracker

  attr_reader :teams, :games, :game_teams, :seasons

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = @game_teams
    @seasons = seasons
  end

  def self.from_csv(locations)
    locations.each do |key, path|
      CSV.foreach(path, :headers => true,
      header_converters: :symbol) do |row|
        if key == :games
          GameManager.new(row.to_h)
          require "pry"; binding.pry
        elsif key == :teams
          TeamManager.new(row.to_h)
          # add stuff
          # Team.new(row.to_h)
        else
          TeamGameManager.new(row.to_h)
          # add stuff
          # GameTeam.new(row.to_h)
        end
      end
    end
  end

end
