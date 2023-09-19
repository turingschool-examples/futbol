require 'csv'


class StatTracker
  def initialize

  end

  def self.from_csv(locations)
    locations.to_a.each do |location|
      contents = CSV.open 'location', headers: true, header_converters: :symbol
    end
  end

end