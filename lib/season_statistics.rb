require_relative "stat_tracker"

class SeasonStatistics
  attr_reader :stat_tracker_copy
  def initialize
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
    @csv_game_table = StatTracker.from_csv(locations)
    @stat_tracker_copy = StatTracker.new
  end

end
