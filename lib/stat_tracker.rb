require 'csv'

class StatTracker
 attr_reader :data

  def initialize(filepath)
    @data = CSV.read(filepath, headers: true,
header_converters: :symbol)
  end

  def self.from_csv

  end

end
