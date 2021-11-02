require 'csv'

class StatTracker

  def initialize
    
  end

  def self.convert_path_to_csv(files)
    result = []
    rows = CSV.read(files, headers:true)
    rows.each do |row|
      result << row
    end
    result
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
    # data = Hash.new
    # locations.each do |symbol, path|
    #   data[symbol] = convert_path_to_csv(path)
    # end
    # data
  end
end
