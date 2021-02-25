module CsvToHash
  def from_csv(csv_file)
    data = CSV.parse(File.read(csv_file), headers: true, converters: :numeric, header_converters: :symbol)
    data.map{|row, i| row.to_h}
  end

end