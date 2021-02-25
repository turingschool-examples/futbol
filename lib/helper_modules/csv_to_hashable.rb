module CsvToHash
  def from_csv(csv_files)
    data = csv_files.map {
    |csv_file|
    CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric, header_converters: :symbol)
    }
    array_of_hash = [[],[],[]]
    data.each_with_index{|file, i| file.each{|row| array_of_hash[i] << row.to_h}}
    @data_hash = Hash.new()
    array_of_hash.each_with_index do |data_set, i|
      files = csv_files.to_a
      @data_hash[files[i][0]] = array_of_hash[i] 
    end
    return @data_hash
    #require 'pry'; binding.pry
  end

end