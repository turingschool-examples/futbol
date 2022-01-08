require 'csv'

module CSVReader
  def generate_data(path, type)
    CSV.read(path)[1..-1].collect do |row|
      type.new(row)
    end
  end
end 
