
require_relative './game_teams'
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games
  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
    # binding.pry
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      file = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = file
    end
    StatTracker.new(stats)
    # stat_tracker = StatTracker.new(locations)
    # stat_tracker.games = Game.create_list_of_game(stat_tracker.games_csv)
  end


    def team_info(team_id)
      teams.by_id(team_id)
    end

  end
