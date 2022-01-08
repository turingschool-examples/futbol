require 'csv'
require 'pry'
require_relative '../game'
require_relative '../csv_reader'

class GameManager
  attr_accessor :data
  include CSVReader

  def initialize(path)
    @data = generate_data(path, Game)
  end
end

a = GameManager.new('./data/game_teams.csv')
