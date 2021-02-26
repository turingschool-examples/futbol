require './lib/helper_modules/csv_to_hashable.rb'
require './lib/instances/game'
class GameTable 
  attr_reader :game_data, :stat_tracker
  include CsvToHash
  def initialize(locations)
    @game_data = from_csv(locations, 'Game')
  end
  
  def other_call(data)
    data
  end
end