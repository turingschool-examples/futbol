require 'csv'
require 'pry'
require_relative '../game_team'
require_relative '../csv_reader'
class GameTeamsManager
  include CSVReader
  attr_accessor :data

  def initialize(path)
    @data = generate_data(path, GameTeam)
  end
end

a = GameTeamsManager.new('./data/game_teams.csv')
