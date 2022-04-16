require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :stats_main, :teams, :game_teams, :games
  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
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

  # Start Game Statistics methods
  def highest_total_score
    @games.total_scores.max
  end

  def lowest_total_score
    @games.total_scores.min
  end

  def percentage_home_wins
    (@games.game_outcomes[:home_win].to_f / @games.game_outcomes[:total].to_f) * 100
  end

  def percentage_visitor_wins
    (@games.game_outcomes[:away_win].to_f / @games.game_outcomes[:total].to_f) * 100
  end

  def percentage_ties
    (@games.game_outcomes[:tie].to_f / @games.game_outcomes[:total].to_f) * 100
  end
  # End Game Statistics methods
end
