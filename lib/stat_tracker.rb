require 'csv'
class StatTracker

    def self.from_csv(locations)
        holder = []
        locations.each do |location|
            holder << CSV.open(location[1], headers: true, header_converters: :symbol)
        end

    end
end