require './spec_helper'


class StatTracker

  def initialize
   
  end

  def self.from_csv(locations)
    contents = CSV.open locations[:games], headers: true, header_converters: :symbol
    # contents.map do |row|
    #   row
    # end
    # StatTracker.new
  end
  
end

