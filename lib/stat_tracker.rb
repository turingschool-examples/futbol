require 'pry'
require 'CSV'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def self.from_csv(places) #add .to_a changes to an array
    StatTracker.new(places) #creating an instance of StatTracker holding the hash as locations
  end

  def highest_total_score
    games = CSV.read @locations[:games], headers: true, header_converters: :symbol
    scores_array = []
    games.each do |row|
      scores_array << row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores_array.max

    # binding.pry
    # highest_total_score = games[:away_goals].each do |key|
    # end
    #
    # highest_home_score = games[:home_goals].to_i

  end

end


# locations.each do |location|
#   location.key.to_s = StatTracker.new(location.value)
#   binding.pry
# end
