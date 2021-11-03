require 'csv'

class StatTracker

  attr_reader :data, :games, :teams, :game_teams
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
    formatted_data = {}
    locations.each do |symbol, path|
      formatted_data[symbol] = convert_path_to_csv(path)
    end
    StatTracker.new(formatted_data)
  end

end
