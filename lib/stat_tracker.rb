require 'csv'

class StatTracker
  class << self
    def from_csv(locations)
      grouping = {}
      locations.each do |name, data|
        grouping[name] = read_stats(data)
      end
      grouping
    end

    def read_stats(data)
      CSV.parse(File.read(data), headers: true)
    end
  end
end
