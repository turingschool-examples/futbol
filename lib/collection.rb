require 'csv'

class Collection
  def create_objects(file_path, type)
    csv_objects = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    csv_objects.map { |row| type.new(row)}
  end
end
