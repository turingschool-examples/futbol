require './lib/helper_modules/csv_to_hashable.rb'

class GameTable < StatTracker
  include CsvToHash
  attr_reader :game_data, :stat_tracker
  def initialize(locations)
    @games = from_csv(locations)
  end
  
end