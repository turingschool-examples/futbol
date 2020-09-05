require 'CSV'
# Stat Tracker class
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def game_stats
    game_stats = []
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i

      game_stats << GameStatistics.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals)
    end
    game_stats
  end
end
