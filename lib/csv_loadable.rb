require 'CSV'

module CsvLoadable

  def load_csv_data(path, object)
    fuckshit = CSV.open("#{path}", headers: true, header_converters: :symbol)
    fuckshit.map do |row|
      object.new(row)
    end
  end
end
