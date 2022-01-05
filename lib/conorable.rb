#require './spec/spec_helper'
require 'pry'
require 'csv'
class Test
  def initialize
    @results = []
  end

  def parse(csv)
    @file = CSV.read csv, headers: true, header_converters: :symbol
  end
#gets array of elements from a given header
  def get_all_from_header(header)
    @file.map do |row|
      row[:"#{header}"]
    end
  end


#gets data with given header + criteria
  def rows_with_header_and_criteria(header, criteria)
    @file.filter do |row|
      if row[:"#{header}"] == criteria
        @results.push(row)
      end
    end
  end
#gets uniq
  def uniq_criteria_from_header(header)
    @results.map do |row|
      #binding.pry
      row[:"#{header}"]
    end.uniq
  end

end

test = Test.new
test.parse('./data/baby_data.csv')
p test.get_all_from_header(:result)
p test.rows_with_header_and_criteria(:result, "WIN")
p test.uniq_criteria_from_header(:head_coach)
