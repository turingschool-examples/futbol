require "csv"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(file_paths)
    @games = file_paths[:games]
    @teams = file_paths[:teams]
    @game_teams = file_paths[:game_teams]
  end

  def self.from_csv(file_path_locations)
    self.new(file_path_locations)
  end
end
