require 'CSV'

module CsvParser
  def load_it_up(locations, object)
    csv = CSV.read(locations, headers: true, header_converters: :symbol)
      csv.map do |row|
        object.new(row)
    end
  end
end
