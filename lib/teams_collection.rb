require "csv"
require_relative "./teams"

class TeamsCollection
  attr_reader :collection

  def initialize(csv_location)
    @collection = []
    @csv_location = csv_location
    load_csv
  end

  def load_csv
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
    @collection << Teams.new(row)
    end
  end
end
