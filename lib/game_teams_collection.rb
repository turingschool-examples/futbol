require 'csv'
require_relative './game_teams'

class GameTeamsCollection
  attr_reader :collection

  def initialize(csv_location)
    @collection = []
    @csv_location = csv_location
  end

  def load_csv
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
      @collection << GameTeams.new(row)
    end
  end
end
