require 'csv'

module CsvLoadable
  def create_instances(csv_file_path, class_object)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      (class_object).new(row)
    end
  end
end
