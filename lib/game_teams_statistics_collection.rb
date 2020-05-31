require 'csv'
require_relative './game_teams'

class GameTeamsStatisticsCollection
  attr_reader :game_teams_csv_location,
              :collection

  def initialize(game_teams_csv_location)
    @collection = []
    @game_teams_csv_location = game_teams_csv_location
    load_csv
  end

  def load_csv
    CSV.foreach(@game_teams_csv_location, :headers => true, :header_converters => :symbol) do |row|
      @collection << GameTeams.new(row)
    end
  end
end
