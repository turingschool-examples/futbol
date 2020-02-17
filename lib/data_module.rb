require 'csv'

module DataLoadable

  def csv_data(file_path)
    CSV.open(file_path, headers: :first_row, header_converters: :symbol).map(&:to_h)
  end
end
