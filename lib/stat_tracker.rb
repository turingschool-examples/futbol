
# require_relative './spec_helper'


class StatTracker

  def initialize
  
  end

  def self.from_csv(locations)
    contents = CSV.open locations[:games], headers: true, header_converters: :symbol
    contents.each do |row|
      row
      require 'pry'; binding.pry
    end
    # StatTracker.new
  end

end
