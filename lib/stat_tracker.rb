require 'pry'

class StatTracker


  def initialize(locations)
    @locations = locations
  end

  def self.from_csv(locations) #add .to_a changes to an array
    StatTracker.new(locations) #creating an instance of StatTracker holding the hash as locations
  end


end


# locations.each do |location|
#   location.key.to_s = StatTracker.new(location.value)
#   binding.pry
# end
