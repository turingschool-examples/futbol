require "csv"
require_relative "./teams"

class TeamsStatisticsCollection
  attr_reader :csv_location,
              :collection

  def initialize(csv_location)
    @csv_location = csv_location
    @collection = []
  end

  def load_csv
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
    @collection << Teams.new(row)
    end
  end
end
