module Averageable
  #designed to take in an array of objects and average based on what needs to be averaged
  def take_average(array, stat_to_average)
    array.map {|team| hash[team[0]] = team[1].map{|game| game.stat_to_average}.sum.to_f / team[1].length}
  end
end