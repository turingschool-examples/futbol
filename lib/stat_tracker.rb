class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path, :game_collection, :team_collection

  def initialize(stat_tracker_params)
    @games_path = stat_tracker_params[:games]
    @teams_path = stat_tracker_params[:teams]
    @game_teams_path = stat_tracker_params[:game_teams]
    @game_collection = GameCollection.new(@games_path)
    @team_collection = TeamCollection.new(@teams_path)
    @gt_collection = GameTeamCollection.new(@game_teams_path)
  end

  def self.from_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  def games
    @game_collection.all
  end

  def teams
    @team_collection.all
  end

  def game_teams
    @gt_collection.all
  end

  # GAME STATISTICS
  def highest_total_score
    games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    games.min_by { |game| game.total_goals }.total_goals
  end

  # LEAGUE STATISTICS

  # SEASON STATISTICS

  # winningest_coach	Name of the Coach with the best win percentage for the season	String
  def winningest_coach(season_id)
    #season_id will reference all games played in that season. This will start in game_collection, then use team_id to reference gt_collection and finally return the head_coach name as a string

  end
  # worst_coach	Name of the Coach with the worst win percentage for the season	String
  #
  # most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
  #
  # least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
  #
  # most_tackles	Name of the Team with the most tackles in the season	String
  #
  # fewest_tackles	Name of the Team with the fewest tackles in the season	String
  #

  # TEAM STATISTICS

  def team_info(id)
    teams.find do |team|
      team.team_id == id
    end.info
  end

  def most_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.max
  end

  def fewest_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.min
  end

end
