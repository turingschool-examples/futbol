require 'csv'

class StatTracker
 attr_reader :data

  def initialize(filepath)
    @data = CSV.read(filepath, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    locations.map {|key, filepath| [key, StatTracker.new(filepath)]}.to_h
  end

end
