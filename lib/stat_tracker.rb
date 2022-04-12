class StatTracker

  def self.from_csv(locations)
    csv_hash = {}
    locations.each do |file_key, location_value|
    csv_hash[file_key] = CSV.open(location_value, headers: true, header_converters: :symbol)
    end
    csv_hash
  end
end
