require 'csv'

module Readable
  def from_csv(path, class_type)
    rows = CSV.read(path, headers: true, header_converters: :symbol)
    rows.map do |row|
      class_type.new(row)
    end
  end
end
