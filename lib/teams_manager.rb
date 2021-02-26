require 'CSV'

class TeamsManager
  attr_reader :games, :locations

  def initialize(data, stat_tracker)
    @data = data
    @stat_tracker = stat_tracker
    @games = []
  end

  def create_games(location)
    result = CSV.parse(File.read(location), headers: true)
    result.map do |row|
      @games << Team.new(row, self)
    end
  end

end
