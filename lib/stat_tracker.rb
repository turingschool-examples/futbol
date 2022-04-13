class StatTracker
  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      file = CSV.read(location_value, headers: true, header_converters: :symbol)
      header_key_val_pairs = {}
      file.headers.each do |header|
        header_key_val_pairs[header] = []
      end
      file.each do |row|
        row.each do |header, data|
          header_key_val_pairs[header] << data
        end
      end
      stats[file_key] = header_key_val_pairs
    end
    stats
  end
end
