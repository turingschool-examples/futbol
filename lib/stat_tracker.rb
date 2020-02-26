require 'csv'
require_relative './game_teams_collection'
require_relative './game_collection'
require_relative './team_collection'

class StatTracker

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
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
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
    retrieve_team(totals.key(totals.values.max)).teamname
  end

  def worst_offense
    totals = @gtc.offense_rankings
    retrieve_team(totals.key(totals.values.min)).teamname
  end

  def best_defense
    totals = @game_collection.defense_rankings
    retrieve_team(totals.key(totals.values.min)).teamname
  end

  def worst_defense
    totals = @game_collection.defense_rankings
    retrieve_team(totals.key(totals.values.max)).teamname
  end

  def lowest_scoring_visitor
    totals = @gtc.scores_as_visitor
    retrieve_team(totals.key(totals.values.min)).teamname
  end

  def worst_fans
    teams = gtc.hoa_wins_by_team("away").select do |team, away_wins|
      gtc.hoa_wins_by_team("home")[team] < away_wins
    end.keys
    teams.map { |team_id| team_name_by_id(team_id) }
  end

  def lowest_scoring_home_team
    team_name_by_id(@gtc.scores_as_home_team.key(@gtc.scores_as_home_team.values.min))
  end

  def highest_scoring_home_team
    team_name_by_id(@gtc.scores_as_home_team.key(@gtc.scores_as_home_team.values.max))
  end

  def winningest_team
    game_collection.total_games_by_team
    gtc.total_wins_by_team
    winning_percentages = game_collection.total_games_by_team.merge(game_collection.total_games_by_team) do |team_id, total_games|
      gtc.total_wins_by_team[team_id] / total_games.to_f
    end
    team_name_by_id(winning_percentages.key(winning_percentages.values.max))
  end

  def highest_scoring_visitor
    totals = @gtc.scores_as_visitor
    retrieve_team(totals.key(totals.values.max)).teamname
  end

  def best_fans
    home_percentage = @gtc.hoa_win_percentage('home')
    away_percentage = @gtc.hoa_win_percentage('away')

    differences = home_percentage.merge(home_percentage) do |team, percent|
      (percent - away_percentage[team])
    end
    team_and_difference = differences.max_by { |team, difference| difference}
    team_name_by_id(team_and_difference[0])
  end

  def team_name_by_id(team_id)
    team_collection.teams.find do |team|
      team.team_id == team_id
    end.teamname
  end

  def most_tackles(season)
    team_name_by_id(gtc.season_tackles(season).key(gtc.season_tackles(season).values.max))
  end

  def fewest_tackles(season)
    team_name_by_id(gtc.season_tackles(season).key(gtc.season_tackles(season).values.min))
  end

  def team_info(team_num)
    info = {}
    team_obj = retrieve_team(team_num.to_i)
      info["team_id"] = team_obj.team_id.to_s
      info["franchise_id"] = team_obj.franchiseid.to_s
      info["team_name"] = team_obj.teamname
      info["abbreviation"] = team_obj.abbreviation
      info["link"] = team_obj.link
      info
  end

  def most_goals_scored(team_num)
    total_scores_by_team(team_num).max
  end

  def fewest_goals_scored(team_num)
    total_scores_by_team(team_num).min
  end

  def retrieve_team(team_num)
    team_collection.teams.find { |team_obj| team_obj.team_id == team_num }
  end

  def total_scores_by_team(team_num)
    game_collection.games.reduce([]) do |scores, game|
      if team_num.to_i == game.home_team_id
        scores << game.home_goals
      elsif team_num.to_i == game.away_team_id
        scores << game.away_goals
      end
      scores
    end
  end
end
