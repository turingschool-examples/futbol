require "csv"
require_relative "./games"

class GamesCollection
  attr_reader :collection

  def initialize(csv_location)
    @collection = []
    @csv_location = csv_location
  end

  def load_csv
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
      @collection << Games.new(row)
    end
  end
end
