require_relative './game_collection'
require_relative './game'
require_relative './game_teams'
require_relative './team'



class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_collection = game_collection
    @game_teams = GameTeams.from_csv(game_teams_path)
    Team.from_csv(team_path)
    @teams = Team.all
  end

  def game_collection
     GameCollection.new(@game_path)
  end

  def percentage_home_wins
    @game_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_collection.percentage_visitor_wins
  end

  def percentage_ties
    @game_collection.percentage_ties
  end

  def average_goals_by_season
    @game_collection.average_goals_by_season
  end

  def average_goals_per_game
    @game_collection.average_goals_per_game
  end

  def highest_total_score
    @game_collection.highest_total_score
  end

  def lowest_total_score
    @game_collection.lowest_total_score
  end

  def biggest_blowout
    @game_collection.biggest_blowout
  end

  def count_of_games_by_season
    @game_collection.count_of_games_by_season
  end

  def winningest_team
    GameTeams.winningest_team
  end

  def best_fans
    GameTeams.best_fans
  end

  def worst_fans
    GameTeams.worst_fans
  end

  def count_of_teams
    Team.count_of_teams
  end

  def highest_scoring_visitor
    GameTeams.highest_scoring_visitor
  end

  def highest_scoring_home_team
    GameTeams.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    GameTeams.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    GameTeams.lowest_scoring_home_team
  end

  def best_offense
    @game_collection.best_offense
  end

  def worst_offense
    @game_collection.worst_offense
  end

  def worst_defense
    @game_collection.worst_defense
  end

  def best_defense
    @game_collection.best_defense
  end

end
