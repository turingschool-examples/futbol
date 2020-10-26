require 'CSV'
class StatTracker
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.from_csv(locations)
    @data = []
    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @data << row
    end

    stat_tracker = StatTracker.new(@data)
    require 'pry'; binding.pry
  end

end