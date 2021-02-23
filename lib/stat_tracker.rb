require 'CSV'

class StatTracker

  def initialize
  end

  def self.from_csv(data_locations)
    CSV.foreach(data_locations[:games], headers: true, header_converters: :symbol) do |row|
      
    end
  end

end
