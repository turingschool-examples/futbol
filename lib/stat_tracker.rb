require 'pry'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(files)
    @game_path = files[:games]
    @team_path = files[:teams]
    @game_teams_path = files[:game_teams]
  end

  def self.from_csv(files)
    stats = StatTracker.new(files)
  end
end
