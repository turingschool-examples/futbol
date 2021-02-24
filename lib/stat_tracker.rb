require 'csv'
require 'active_support'

class StatTracker 


  def self.from_csv(csv_files)
    data = []
    # csv_files.map{ |file|
    #   CSV.parse(File.read(file[1]), headers: true, converters: :numeric, header_converters: :symbol).map{
    #   |row| 
    #   headers ||= row.headers
    #   data << row.to_h
    # }}
    csv_files.map {
      |csv_file| 
      symbol = csv_file[0]
      CSV.parse(File.read(csv_file[1]),converters: :numeric).map{|item| item}
    }
    require 'pry'; binding.pry
  end
  # CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric).map{|line| line}
end

