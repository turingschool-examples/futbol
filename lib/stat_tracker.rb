# frozen_string_literal: true

# Stat tracker class
class StatTracker
  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_team_path = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
