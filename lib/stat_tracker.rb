require 'csv'
require 'smarter_csv'
require 'active_support'
class StatTracker 


  def self.from_csv(import_data)
    @data = import_data.map {
      |csv_file| 
      SmarterCSV.process(csv_file[1])
    }
    blah
  end

end

