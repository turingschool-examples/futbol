require 'csv'

module DataLoadable

  def csv_data(file_path, object)
    csv = CSV.open(file_path, headers: :first_row, header_converters: :symbol)
    csv.map{ |row| object.new(row) }
  end
end
