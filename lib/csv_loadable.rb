require 'csv'

module CsvLoadable
  def create_instances(file_path, class_object)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @objects = csv.map do |row|
      (class_object).new(row)
    end
  end
end
