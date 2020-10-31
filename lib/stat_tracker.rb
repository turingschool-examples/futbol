require_relative './game.rb'
require_relative './team.rb'
require_relative './game_team.rb'
require_relative './game_statistics.rb'
require_relative './season_statistics.rb'
require_relative './team_statistics.rb'
require_relative './league_statistics.rb'
require_relative './object_data.rb'
require 'CSV'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @locations = locations
    @team_statistics = TeamStatistics.new
    @season_statistics = SeasonStatistics.new
    @game_statistics = GameStatistics.new
    @league_statistics = LeagueStatistics.new
    @object_data ||= ObjectData.new(self)
  end
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  def retrieve_game_teams
    output_hash = {}
    CSV.foreach(@locations[:game_teams], headers: true) do |row|
      output_hash[row[0]] = {} if !output_hash[row[0]]
      output_hash[row[0]][row[2]] = GameTeam.new(row)
    end
    output_hash
  end
  def retrieve_games
    output_hash = {}
    CSV.foreach(@locations[:games], headers: true) do |row|
      output_hash[row[0]] = Game.new(row)
    end
    output_hash
  end
  def retrieve_teams
    output_hash = {}
    CSV.foreach(@locations[:teams], headers: true) do |row|
      output_hash[row[0]] = Team.new(row)
    end
    output_hash
  end
  def highest_total_score
    @game_statistics.highest_total_score(@object_data.games)
  end
  def lowest_total_score
     @game_statistics.lowest_total_score(@object_data.games)
  end
  def percentage_home_wins
    @game_statistics.percentage_home_wins(@object_data.games)
  end
  def percentage_visitor_wins
    @game_statistics.percentage_visitor_wins(@object_data.games)
  end
  def percentage_ties
    @game_statistics.percentage_ties(@object_data.games)
  end
  def count_of_games_by_season
    @game_statistics.count_of_games_by_season(@object_data.games)
  end
  def average_goals_per_game
    @game_statistics.average_goals_per_game(@object_data.games)
  end
  def average_goals_by_season
    @game_statistics.average_goals_by_season(@object_data.games)
  end
  def winningest_coach(season)
    @season_statistics.winningest_coach(season, @object_data.games, @object_data.game_teams)
  end
  def worst_coach(season)
    @season_statistics.worst_coach(season, @object_data.games, @object_data.game_teams)
  end
  def most_accurate_team(season)
    @season_statistics.most_accurate_team(season, @object_data.games, @object_data.game_teams, @object_data.teams)
  end
  def least_accurate_team(season)
    @season_statistics.least_accurate_team(season, @object_data.games, @object_data.game_teams, @object_data.teams)
  end
  def most_tackles(season)
    @season_statistics.most_tackles(season, @object_data.games, @object_data.game_teams, @object_data.teams)
  end
  def fewest_tackles(season)
    @season_statistics.fewest_tackles(season, @object_data.games, @object_data.game_teams, @object_data.teams)
  end
  def team_info(team_id)
    @team_statistics.team_info(@object_data.teams, team_id)
  end
  def best_season(team_id)
    @team_statistics.best_season(@object_data.games, "6")
  end
  def worst_season(team_id)
    @team_statistics.worst_season(@object_data.games, "6")
  end
  def average_win_percentage(team_id)
    @team_statistics.average_win_percentage(@object_data.games, "6")
  end
  def most_goals_scored(team_id)
    @team_statistics.most_goals_scored(@object_data.games, team_id)
  end
  def fewest_goals_scored(team_id)
    @team_statistics.fewest_goals_scored(@object_data.games, team_id)
  end
  def favorite_opponent(team_id)
    @team_statistics.favorite_opponent(@object_data.games, @object_data.teams, team_id)
  end
  def rival(team_id)
    @team_statistics.rival(@object_data.games, @object_data.teams, team_id)
  end
  def count_of_teams
    @league_statistics.count_of_teams(@object_data.teams)
  end
  def best_offense
    @league_statistics.best_offense(@object_data.game_teams,@object_data.teams)
  end
  def worst_offense
    @league_statistics.worst_offense(@object_data.game_teams,@object_data.teams)
  end
  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor(@object_data.games,@object_data.teams)
  end
  def highest_scoring_home_team
    @league_statistics.highest_scoring_home_team(@object_data.games,@object_data.teams)
  end
  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor(@object_data.games,@object_data.teams)
  end
  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team(@object_data.games,@object_data.teams)
  end
end
