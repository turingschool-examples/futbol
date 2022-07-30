require 'csv'
require 'pry'
require 'data_warehouse'
require 'season_stats'

class StatTracker

  attr_reader :data_warehouse


  def initialize(games, teams, game_teams)
    @data_warehouse = DataWarehouse.new(games, teams, game_teams)
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    )
  end

  def winningest_coach(target_season)
    data = @data_warehouse.data_by_season(target_season)
    season_stats = SeasonStats.new(data)
    season_stats.winningest_coach
  end

  def worst_coach(target_season)
    data = @data_warehouse.data_by_season(target_season)
    season_stats = SeasonStats.new(data)
    season_stats.worst_coach
  end

  def most_accurate_team(target_season)
    data = @data_warehouse.data_by_season(target_season)
    key = @data_warehouse.id_team_key
    season_stats = SeasonStats.new(data, key)
    season_stats.most_accurate_team
  end

  def least_accurate_team(target_season)
    data = @data_warehouse.data_by_season(target_season)
    key = @data_warehouse.id_team_key
    season_stats = SeasonStats.new(data, key)
    season_stats.least_accurate_team
  end

  def most_tackles(target_season)
    data = @data_warehouse.data_by_season(target_season)
    key = @data_warehouse.id_team_key
    season_stats = SeasonStats.new(data, key)
    season_stats.most_tackles
  end

  def fewest_tackles(target_season)
    data = @data_warehouse.data_by_season(target_season)
    key = @data_warehouse.id_team_key
    season_stats = SeasonStats.new(data, key)
    season_stats.fewest_tackles
  end

  def count_of_teams
    @data_warehouse.teams.count
  end

  def best_offense
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.best_offense
  end

  def worst_offense
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.worst_offense
  end

  def highest_scoring_visitor
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    data = @data_warehouse
    league_stats = LeagueStats.new(data)
    league_stats.lowest_scoring_home_team
  end

end
