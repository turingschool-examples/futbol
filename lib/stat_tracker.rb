# frozen_string_literal: true

require_relative './game_methods'

# Stat tracker class
class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path

  def initialize(locations)
    @games_path = locations[:games]
    @teams_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @game_methods = GameMethods.new(@games_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @highest_total_score ||= @games_path.highest_total_score
  end
end
