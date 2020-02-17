require 'csv'

class StatTracker
  attr_accessor :game_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end
end
