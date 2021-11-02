require 'csv'

class StatTracker

  def initialize(data)
    @data = data
    @games = @data[:games]
    @teams = @data[:teams]
    @games_teams = @data[:games_test]

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
    formatte_data = {}
    locations.each do |symbol, path|
      @data[symbol] = convert_path_to_csv(path)
    end
    StatTracker.new(formatte_data)
  end

  def self.get_data(data_set)
    @data[data_set]
  end
end
