require 'csv'
require 'pry'

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
    game_collection = GameCollection.new(@games_path)
    game_collection.all
  end

  def teams
    rows = CSV.read(@teams_path, headers: true, header_converters: :symbol)
    rows.reduce([]) do |teams, row|
      teams << Team.new(row)
      teams
    end
  end

  # GAME STATISTICS

  # LEAGUE STATISTICS

  # SEASON STATISTIC

  # TEAM STATISTICS

end
