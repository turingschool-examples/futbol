require 'csv'

class StatTracker
    def self.from_csv(locations)
      all_data = {}
      locations.each do |file_name, data|
        all_data[file_name] = read_data(data)
      end
      all_data
    end

    def self.read_data(data)
      CSV.parse(File.read(data), headers: true)
    end
  end
