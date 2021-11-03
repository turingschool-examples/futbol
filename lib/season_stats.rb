require 'csv'
require 'simplecov'

SimpleCov.start

class SeasonStats
  attr_reader :season_data
  def initialize(season_data)
    @season_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
  end
end
