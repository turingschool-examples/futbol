require 'csv'

class StatTracker

  def self.from_csv(csv_file)
    @data = csv_file.map {
      |csv_file|
      CSV.parse(File.read(csv_file[1]), headers: true, header_converters: :symbol, converters: :numeric)
    }
    hash = Hash.new()
    csv_file.each_with_index do |file, i|
      hash[file[0]] = @data[i] 
    end
    hash
  end
end
