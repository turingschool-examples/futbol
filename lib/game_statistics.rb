require_relative "stat_tracker"

class GameStatistics
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

  def highest_total_score
    highest_total = 0
    @csv_game_table.games.each do |key, value|
      total = value.away_goals + value.home_goals
      if total > highest_total
        highest_total = total
      end
    end
    @stat_tracker_copy.highest_total_score_stat = highest_total
  end

  def lowest_total_score
    lowest_total = 11
    @csv_game_table.games.each do |key, value|
      total = value.away_goals + value.home_goals
      if lowest_total > total
        lowest_total = total
      end
    end
    @stat_tracker_copy.lowest_total_score_stat = lowest_total
  end
end
