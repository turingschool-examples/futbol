require 'csv'
require 'pry'
require_relative '../game_team'
class GameTeamsManager
  attr_accessor :data

  def initialize(path)
    @data = load_file(path)
  end

  def load_file(path)
    CSV.read(path)[1..-1].collect do |row|
      GameTeam.new(row)
    end
  end
end

$game_team_manager_data = GameTeamsManager.new('./data/game_teams.csv')
# require 'pry'
# binding.pry
