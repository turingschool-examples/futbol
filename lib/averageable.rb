module Averageable #each module should have a defined purpose/goal; think "addressable"; there could be value in using a certain thing on another class

  def minimum(average) #helper method
    average.min { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def maximum(average) #helper method
    average.max { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

end
