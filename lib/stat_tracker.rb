class StatTracker
  attr_reader :teams,
              :games
  def initialize
    @teams = []
    @games = []
  end

  def self.from_csv(locations)
    all_open_csvs = locations.map do |file, location|
      (CSV.open location, headers: true, header_converters: :symbol)
    end
    # @teams << all_open_csvs[1]
    require 'pry'; binding.pry
    # @games << all_open_csvs[0]
    # @games << all_open_csvs[2]
  end
end