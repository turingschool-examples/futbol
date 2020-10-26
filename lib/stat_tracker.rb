require 'CSV'
class StatTracker
  attr_reader :all_data

  def initialize(data)
    @all_data = data
  end

  def self.from_csv(locations)

    @all_data = {}

    locations.each_pair do |key, location|
        data = []
        CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
        
        
            data << row
        end
        @all_data[key] = data
    end
    stat_tracker = StatTracker.new(@all_data)
  end

end