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
    GameCollection.new(@games_path).all
  end

  def teams
    TeamCollection.new(@teams_path).all
  end

  # GAME STATISTICS
  def highest_total_score
    games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    games.min_by { |game| game.total_goals }.total_goals
  end

  # LEAGUE STATISTICS

  # SEASON STATISTIC

  # TEAM STATISTICS

end
