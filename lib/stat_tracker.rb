require 'csv'

class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path
  def initialize(stat_tracker_params)
    @games_path = stat_tracker_params[:games]
    @teams_path = stat_tracker_params[:teams]
    @game_teams_path = stat_tracker_params[:game_teams]
  end

  def self.from_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  def games
    rows = CSV.read(@games_path, headers: true, header_converters: :symbol)
    rows.reduce([]) do |games, row|
      games << Game.new(row)
      games
    end
  end

  def teams

  end

  # GAME STATISTICS

  # LEAGUE STATISTICS

  # SEASON STATISTIC

  # TEAM STATISTICS

end
