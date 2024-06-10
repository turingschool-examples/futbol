require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'league_stat'
require_relative 'game'
require_relative 'season_stat'
require_relative 'game_stat'


class StatTracker
  attr_reader :team_data, 
              :games, 
              :game_teams_data, 
              :league, 
              :season, 
              :game_stats, 
              :league_stats,
              :season_stats
        

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @team_data = create_objects(locations[:teams], Team, self)   
    @games = create_objects(locations[:games], Game, self)   
    @game_teams_data = create_objects(locations[:game_teams], GameTeam, self)   
    @game_stats = GameStats.new(@games)
    @league_stats = LeagueStats.new(@game_teams_data, @team_data)
    @season_stats = SeasonStats.new(@game_teams_data, @team_data, @games)
  end

  def create_objects(path, obj_class, parent_self)
   data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
   data.map {|d| obj_class.new(d)}
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  def winningest_coach(season_id)
    @season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    @season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    @season_stats.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    @season_stats.fewest_tackles(season_id)
  end
end