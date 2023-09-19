class StatTracker
  attr_reader :all_data
  
  def initialize(all_data)
    @all_data = all_data
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |file_name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[file_name] = formatted_csv
    end
    StatTracker.new(all_data)
  end

  def dummy_method
    @all_data[:gtf].each do |row|
      name = row[:game_id]
      puts "#{name}"
    end
  end

end