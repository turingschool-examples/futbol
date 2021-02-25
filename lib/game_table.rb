require './lib/csv_to_hashable.rb'
class GameTable < StatTracker
  include CsvToHash
  attr_reader :game_data, :stat_tracker
  def initialize(data)
    @games = data
  end
  
end