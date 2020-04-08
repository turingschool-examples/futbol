require 'CSV'
require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
      StatTracker.new(data_files)
  end
  
end
