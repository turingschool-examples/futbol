require 'game'
require 'gameteam'
require 'team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = Game.create_from_csv(locations[:games])
    teams = Team.create_from_csv(locations[:teams])
    game_teams = GameTeam.create_from_csv(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def find_team_name_by_id(team_id)
    Team.find_team_name_by_id(team_id)
  end

  def highest_scoring_home_team 
    find_team_name_by_id(GameTeam.avg_scores_per_team_home.max_by {|team_id, goals| goals}.first)
  end

  def lowest_scoring_home_team
    find_team_name_by_id(GameTeam.avg_scores_per_team_home.min_by {|team_id, goals| goals}.first)
  end
  def highest_total_score
    Game.highest_total_score
  end

  def lowest_total_score
    Game.lowest_total_score
  end

  def count_of_teams
    Team.count_of_teams
  end

  def best_offense
    GameTeam.best_offense
  end

  def worst_offense
    GameTeam.worst_offense
  end

  def most_tackles(season)
    # Game.most_tackles
    # GameTeams.most_tackles
  end





  def percentage_home_wins
    Game.percentage_home_wins
  end

  def percentage_visitor_wins
    Game.percentage_visitor_wins
  end

  def percentage_ties
    Game.percentage_ties
  end

  def count_of_games_by_season
    Game.count_of_games_by_season
  end

  def average_goals_by_season
    Game.average_goals_by_season
  end

  def average_goals_per_game
    Game.average_goals_per_game
  end
  
  def fewest_tackles(season_id)
    team_id = GameTeam.fewest_tackles_by_season(season_id)
    Team.find_team_name_by_id(team_id)
  end
end
