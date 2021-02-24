require 'CSV'
require'./lib/game_data'
require './lib/team_data'
require './lib/game_teams_data'
require 'pry'

class StatTracker # < MethodsClass?

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @game = GameData.new(@game_path)
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end
end
