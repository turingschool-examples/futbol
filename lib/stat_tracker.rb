require 'pry'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def self.from_csv(places) #add .to_a changes to an array
    StatTracker.new(places) #creating an instance of StatTracker holding the hash as locations
  end


end


# locations.each do |location|
#   location.key.to_s = StatTracker.new(location.value)
#   binding.pry
# end
