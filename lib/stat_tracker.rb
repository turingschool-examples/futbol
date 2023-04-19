class StatTracker
  attr_reader :teams,
              :games,
              :all_open_csvs
  def initialize(locations)
    @locations = locations
    @teams = []
    @games = []
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end