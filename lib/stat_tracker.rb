require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(game_path, team_path, game_team_path)
    @games      = CSV.read(game_path)
    @teams      = CSV.read(team_path)
    @game_teams = CSV.read(game_team_path)
  end

  def to_array(file_path)
    rows = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      rows << row.to_h
    end
    # require "pry"; binding.pry
    rows
  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_team_path = locations[:game_teams]
    self.new(game_path, team_path, game_team_path)
  end
end
