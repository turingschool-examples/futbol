require 'csv'
require_relative './helper_modules/team_returnable'
require '../futbol/lib/tables/team_table'
require '../futbol/lib/tables/game_table'
require '../futbol/lib/tables/game_team_tables'

class StatTracker
  include ReturnTeamable
  attr_reader :games, :game_teams, :teams
  
  def initialize(locations)
    @games = GameTable.new(locations[:games])
    @game_teams = GameTeamTable.new(locations[:game_teams])
    @teams = TeamsTable.new(locations[:teams])

  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def game_by_season
    @games.game_by_season
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def percentage_home_wins
    @games.percentage_home_wins
  end

  def percentage_away_wins
    @games.percentage_away_wins
  end

  def percentage_ties
    @games.percentage_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def winningest_coach
    @game_teams.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams.worst_coach(season)
  end

  def most_accurate_team(season)
    return_team(@game_teams.most_accurate_team(season), @teams.team_data).teamname
  end

  def least_accurate_team(season)
    return_team(@game_teams.least_accurate_team(season), @teams.team_data).teamname
  end


  def most_tackles(seasson)
    return_team(@game_teams.most_tackles(season), @teams.team_data).teamname
  end

  def fewest_tackles(season)
    return_team(@game_teams.fewest_tackles(season), @teams.team_data).teamname
  end

  def games_by_season(season)
    @game_teams.games_by_season(season)
  end

  def count_of_teams
    @teams.count_of_teams
  end

  def worst_offense
    @game_teams.worst_offense
  end

  def highest_scoring_home_team
    @game_teams.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @game_teams.lowest_scoring_home_team
  end

  def team_info(team_id_str)
    @teams.team_info(return_team(team_id_str.to_i, @teams.team_data))
  end

  def worst_season(team_id_str)
    year = @game_teams.worst_season(team_id_str.to_i)
    #add back in the 2nd year of season
    year + (year.to_i + 1).to_s
  end

  def most_goals_scored(team_id_str)
    @game_teams.most_goals_scored(team_id_str)
  end

  def favorite_opponent(team_id_str)
    #sends array [game_id,result]
    require 'pry'; binding.pry
    games = find_team_games(team_id_str).map{|game|[game.game_id,game.result]}
    @games.favorite_opponent([games, team_id_str])
  end

  def game_by_season(season)
    @game_teams.game_by_season(season)
  end

  def best_offense
    return_team(@game_teams.best_offense).teamname
  end

  def highest_scoring_visitor
    return_team(@game_teams.highest_scoring_visitor,).teamname
  end

  def lowest_scoring_visitor
    @game_teams.lowest_scoring_visitor
  end

  def best_season(team_id_str)
    year = @game_teams.best_season(team_id_str.to_i)
    year + (year.to_i + 1).to_s
  end

  def fewest_goals_scored(team_id_str)
    @game_teams.fewest_goals_scored(team_id_str)
  end

  def rival(team_id_str)
    games = @game_teams.find_team_games(team_id_str).map{|game|[game.game_id,game.result]}
    @games.rival(games)
  end
  def find_team_games(team_id_str)
    @game_teams.game_team_data.find_all{|game| game.team_id == team_id_str.to_i}
  end

  def average_win_percentage(team_id)
    @game_teams.average_win_percentage(team_id)
  end
end
