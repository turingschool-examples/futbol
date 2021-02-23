require 'csv'

class StatTracker


  def self.from_csv(csv_file)
    @data = csv_file.map {
      |csv_file|
      CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric)
    }
    require "pry"; binding.pry
    # teams = CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric)
  end
end
