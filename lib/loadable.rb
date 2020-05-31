require 'csv'

module Loadable
  def load_from_csv(file_path, class_instance)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    csv.map { |row| class_instance.new(row) }
  end
end
