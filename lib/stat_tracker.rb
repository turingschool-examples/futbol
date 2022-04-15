class StatTracker
  def initialize(stat_tracker)
    @games = stat_tracker[:games]
    @teams = stat_tracker[:teams]
    @game_teams = stat_tracker[:game_teams]
    @stat_tracker = stat_tracker
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      file = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = file
    end
    StatTracker.new(stats)
  end
end
