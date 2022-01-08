require 'csv'
require_relative '../team.rb'
require_relative '../csv_reader'
require 'pry'
# TeamManager reads CSV data and converts it into an array of Team objects

class TeamManager
  attr_accessor :data
  include CSVReader

  def initialize(path)
    # returns an array of Team objects that each possess header attributes
    @data = generate_data(path, Team)
  end
end

a = TeamManager.new('./data/game_teams.csv')
