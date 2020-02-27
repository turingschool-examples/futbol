require 'csv'
require_relative './game_teams_collection'
require_relative './game_collection'
require_relative './team_collection'
require_relative '../modules/nameable.rb'
class StatTracker
  include Nameable

  def self.from_csv(locations)
    raw_data = {}
    raw_data[:game_data] = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    raw_data[:team_data] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    raw_data[:game_teams_data] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(raw_data)
  end

  attr_reader :game_collection, :team_collection, :gtc
  def initialize(raw_data)
    @game_data = raw_data[:game_data]
    @team_data = raw_data[:team_data]
    @game_teams_data = raw_data[:game_teams_data]
    construct_collections
  end

  def construct_collections
    @gtc = GameTeamsCollection.new(@game_teams_data)
    @game_collection = GameCollection.new(@game_data)
    @team_collection = TeamCollection.new(@team_data)
  end

  def highest_total_score
    game_collection.highest_total_score
  end

  def lowest_total_score
    game_collection.lowest_total_score
  end

  def biggest_blowout
    game_collection.biggest_blowout
  end

  def percentage_home_wins
    game_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    game_collection.percentage_visitor_wins
  end

  def percentage_ties
    game_collection.percentage_ties
  end

  def count_of_games_by_season
    game_collection.count_of_games_by_season
  end

  def average_goals_per_game
    game_collection.average_goals_per_game
  end

  def average_goals_by_season
    game_collection.average_goals_by_season
  end

  def count_of_teams
    @team_collection.count_of_teams
  end

  def best_offense
    totals = @gtc.offense_rankings
    @team_collection.retrieve_team(totals.key(totals.values.max)).teamname
  end

  def worst_offense
    totals = @gtc.offense_rankings
    @team_collection.retrieve_team(totals.key(totals.values.min)).teamname
  end

  def best_defense
    totals = @game_collection.defense_rankings
    @team_collection.retrieve_team(totals.key(totals.values.min)).teamname
  end

  def worst_defense
    totals = @game_collection.defense_rankings
    @team_collection.retrieve_team(totals.key(totals.values.max)).teamname
  end

  def lowest_scoring_visitor
    totals = @gtc.scores_as_visitor
    @team_collection.retrieve_team(totals.key(totals.values.min)).teamname
  end

  def worst_fans
    @gtc.hoa_wins_by_team("away").select do |team, away_wins|
      @gtc.hoa_wins_by_team("home")[team] < away_wins
    end.keys.map { |team_id| team_name_by_id(team_id) }
  end

  def lowest_scoring_home_team
    min_team_name(@gtc.scores_as_home_team)
  end

  def highest_scoring_home_team
    max_team_name(@gtc.scores_as_home_team)
  end

  def winningest_team
    win_ratio = @game_collection.total_games_by_team.merge(@game_collection.total_games_by_team) do |team_id, total_games|
      @gtc.total_wins_by_team[team_id] / total_games.to_f
    end
    max_team_name(win_ratio)
  end

  def highest_scoring_visitor
    max_team_name(@gtc.scores_as_visitor)
  end

  def best_fans
    home_percentage = @gtc.hoa_win_percentage('home')
    away_percentage = @gtc.hoa_win_percentage('away')
    differences = home_percentage.merge(home_percentage) do |team, percent|
      (percent - away_percentage[team])
    end
    team_name_by_id(differences.max_by { |team, difference| difference}.first)
  end

  def team_name_by_id(team_id)
    team_collection.teams.find { |team| team.team_id == team_id}.teamname
  end

  def most_tackles(season)
    max_team_name(@gtc.season_tackles(season))
  end

  def fewest_tackles(season)
    min_team_name(@gtc.season_tackles(season))
  end

  def team_info(team_num)
    @team_collection.team_info(team_num)
  end

  def most_goals_scored(team_num)
    @game_collection.total_scores_by_team(team_num).max
  end

  def fewest_goals_scored(team_num)
    @game_collection.total_scores_by_team(team_num).min
  end
end
