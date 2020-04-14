class Collection

  def initialize(csv_file_path, class_name)
    @all = nil
  end

  def from_csv(file_path, class_name)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @all = csv.map do |row|
      class_name.new(row)
    end
  end

  def all
    @all
  end

end
