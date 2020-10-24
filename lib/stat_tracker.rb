require 'csv'
class StatTracker
  

    def initialize
    end

    def self.from_csv(locations)
        table = []
        locations.each_value do |value|
            # value.parse
            table << CSV.parse(File.read(value), headers: true)
        end 
    end
end