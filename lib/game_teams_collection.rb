require './lib/game_team'
require 'csv'

class GameTeamsCollection

  @@all_game_teams = []
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def self.all_game_teams
    @@all_game_teams
  end

  def self.from_csv(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |game_team_data|
      add_game_team(game_team_data)
    end
  end

  def self.add_game_team(data)
    @@all_game_teams << GameTeam.new(data)
  end


end
