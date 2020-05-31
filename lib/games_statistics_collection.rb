require "csv"
require_relative "./games"

class GameStatisticsCollection
  attr_reader :csv_location,
              :collection

  def initialize(csv_location)
    @collection = []
    @csv_location = csv_location
    load_csv
  end

  def load_csv
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
      @collection << Games.new(row)
    end
  end
end
