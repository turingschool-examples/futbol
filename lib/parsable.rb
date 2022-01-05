require 'csv'
require 'pry'
module Parsable

  def parse(csv)
    CSV.read csv, headers: true, header_converters: :symbol
  end

  def filter_by_header(csv, header)
    parse(csv).map do |row|
      row[header]
    end
  end

  def criteria_filter(csv, header, criteria)
    result = []
    parse(csv).filter do |row|
      result << row if row[header] == criteria
    end
  end

  def get_key_value(csv, header)
    output = parse(csv).group_by do |row|
      binding.pry
      row[header]
    end
  end

end
