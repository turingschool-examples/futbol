require 'csv'

module Parsable

  def parse(csv)
    CSV.read csv, headers: true, header_converters: :symbol
  end

  def get_row(row)
    row[]
  end
end
