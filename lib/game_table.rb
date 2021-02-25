require './lib/csv_to_hashable.rb'
class GameTable
  include CsvToHash
  attr_reader :game_data, :stat_tracker
  def initialize(data)
    @games = data
    super()
  end
  def set_data
    p 'yes'
  end
  
end