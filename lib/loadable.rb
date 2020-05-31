require 'csv'

module Loadable
  def load_from_csv(file_path, class_constant)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    csv.map { |row| class_constant.new(row) }
  end
end
