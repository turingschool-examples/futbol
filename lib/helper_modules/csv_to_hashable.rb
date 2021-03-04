module CsvToHash
  def from_csv(csv_file, identity)
    data = CSV.parse(File.read(csv_file), headers: true, converters: :numeric, header_converters: :symbol)
    array_of_hash = data.map{|row| row.to_h}
    table = Kernel.const_get(identity)
    array_of_hash.map {|row|  table.new(row)}
  end

end
