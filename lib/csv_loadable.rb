require 'CSV'

class CsvLoadable

  def load_csv_data(path, object)
    data = CSV.open("#{path}", headers: true, header_converters: :symbol)
    data.map do |row|
      object.new(row)
    end
  end
end
