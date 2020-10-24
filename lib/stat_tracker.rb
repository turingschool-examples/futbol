require 'csv'
class StatTracker
  

    def initialize
    end

    def self.from_csv(locations)
        table = {}
        locations.each_pair do |key, value|
            # value.parse
            table[key] = CSV.parse(File.read(value), headers: true, header_converters: :symbol)
        end 
        table
    end

end