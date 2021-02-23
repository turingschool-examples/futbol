require 'csv'
require 'smarter_csv'

class StatTracker 
  attr_reader :data
  
  def initialize
    @data = []
  end

  def self.from_csv(import_data)
    #p import_data[:games]
    @data = import_data.map {
      |csv_file| 
      SmarterCSV.process(csv_file[1])
    }
    #p CSV.parse(File.read(import_data[:games]), headers: true)
  end
end
