module DataLoadable
  def load_data(file_path, data_type)
    csv = CSV.read(file_path, :headers => true,
    header_converters: :symbol)
      csv.map do |row|
      data_type.new(row)
    end
  end
end
