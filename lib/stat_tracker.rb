class StatTracker
  attr_reader :teams,
              :games
  def initialize()
    @teams = []
    @games = []
  end

  def self.from_csv(locations)
    all_open_csvs = locations.map do |file, location|
      (CSV.open location, headers: true, header_converters: :symbol)
    end
  end
end