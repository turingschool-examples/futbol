require_relative "./game_collection"
require_relative "./team_collection"
require_relative "./gt_collection"

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

  # SEASON STATISTIC

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

<<<<<<< HEAD
  # #helper method for best_season
  # def game_winner(game_id)
  # end

  # STUCK ON
  def best_season(team_id)
    games_for_team_id = game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
    # get relevant games (per team id),
    # extract season id for each of 'games_for_team_id' collection
    # make new array of arrays, each sub array is a [season_id, win/loss/tie]
    # make new hash object
    # iterate through that collection of arrays, new hash key is season id,
    # and value is another hash with win => #, loss => #


    game_results = []
    games_for_team_id.each do |game_team|
      game_results = games.find_all do |game|
        game_team.game_id == game.game_id
        # return season?
      end
    end
  end
=======
>>>>>>> master

end
