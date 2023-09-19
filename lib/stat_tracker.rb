class StatTracker
  attr_reader :all_data
  def initialize(all_data)
    @all_data = all_data
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[name] = formatted_csv
    end
    StatTracker.new(all_data)
  end
end