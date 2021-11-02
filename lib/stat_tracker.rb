class StatTracker
  attr_accessor :location
  def initialize(location)
    @location = location
  end

  def self.from_csv(locations)
    locations.map do |location|
      require 'pry'; binding.pry
      StatTracker.new(location)
    end
  end
end
