require_relative './game_teams'

class StatTracker
  attr_reader :stats_main, :teams, :game_teams
  def initialize(stat_tracker)
    @games = stat_tracker[:games]
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])

    @stats_main = stat_tracker
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
