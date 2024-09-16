require 'CSV'

class StatTracker
  attr_reader :stats

  def initialize
    @stats = []
  end
  
  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      stat_tracker = StatTracker.new
      @stats << stat_tracker
    end
    @stats
  end
end