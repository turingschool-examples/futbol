#require './lib/helper_modules/csv_to_hashable.rb'

class GameTable 
  attr_reader :game_data, :stat_tracker
  #include CsvToHash
  def initialize(locations)
    #from_csv(locations)
  end
  
  def other_call(data)
    data
  end
end