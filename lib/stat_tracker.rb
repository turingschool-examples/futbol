class StatTracker
  def self.from_csv(locations)
    StatTracker.new

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      row
    end
  end
end
