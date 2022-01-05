require 'csv'

module Parsable

  def parse(csv)
    CSV.read csv, headers: true, header_converters: :symbol
  end

  def get_row(row)
    row[]
  end

  def filter_by_header(csv, header)
    parse(csv).map do |row|
      row[header]
    end
  end

end
