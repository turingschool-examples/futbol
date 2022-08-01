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

  def all_goals
    #array of all goals
    goals = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end

    goals
  end

  def highest_total_score
    all_goals.max
  end

  def lowest_total_score
    all_goals.min
  end

  def percentage_home_wins
    home_wins = []
    all_home_games = []

    @game_teams.each do |row|
      home_wins << row if row[:hoa] == "home" && row[:result] == "WIN"
      all_home_games << row if row[:hoa] == "home"
    end

    ((home_wins.count / all_home_games.count.to_f).round(2))
  end

  def percentage_visitor_wins
    vistor_wins = []
    all_vistor_games = []

    @game_teams.each do |row|
      vistor_wins << row if row[:hoa] == "away" && row[:result] == "WIN"
      all_vistor_games << row if row[:hoa] == "away"
    end

    ((vistor_wins.count / all_vistor_games.count.to_f).round(2))
  end

  def percentage_ties
    ties = []
    all_games = []

    @game_teams.each do |row|
      ties << row if row[:result] == "TIE"
      all_games << row[:result]
    end

    ((ties.count / all_games.count.to_f).round(2))
  end

  def count_of_games_by_season
    #hash
    game_count_by_season = Hash.new { 0 }

    games.each do |game|
      season_key = game[:season]

      if game_count_by_season[season_key].nil?
      end

      game_count_by_season[season_key] += 1
    end

    game_count_by_season
  end

  def total_goals
    home_goals = 0
    away_goals = 0
    total_goals = 0

    @games.each do |game|
      home_goals += game[:home_goals].to_i
      away_goals += game[:away_goals].to_i
    end

    total_goals = (home_goals + away_goals)
  end

  def total_games
    count_of_games_by_season.values.sum
  end

  def average_goals_per_game
    (total_goals / total_games.to_f).round(2)
  end

  def average_goals_by_season
    total_games_per_season = Hash.new { |hash, season| hash[season] = [] }

    @games.each do |game|
      home_goals = game[:home_goals].to_i
      away_goals = game[:away_goals].to_i
      total_game_goals = (home_goals + away_goals)
      total_games_per_season[game[:season]] << total_game_goals
    end

    average_games_per_season = total_games_per_season.map { |season, games| [season, (games.sum / games.size.to_f).round(2)] }.to_h
  end

  def team_info(search_team_id)
    team_search_info = @data_warehouse.teams.find do |team|
      team[:team_id] == search_team_id
    end
    {
      "team_id" => team_search_info[:team_id],
      "franchise_id" => team_search_info[:franchiseid],
      "team_name" => team_search_info[:teamname],
      "abbreviation" => team_search_info[:abbreviation],
      "link" => team_search_info[:link]
    }
  end

  def best_season(search_team_id)
    data = @data_warehouse.season_stats(search_team_id)
    team_stats = TeamStats.new(data)
    team_stats.best_season
  end

  def worst_season(search_team_id)
    data = @data_warehouse.season_stats(search_team_id)
    team_stats = TeamStats.new(data)
    team_stats.worst_season
  end

  def average_win_percentage(search_team_id)
    all_win_info = []
      @data_warehouse.game_teams.each do |game_team|
        if game_team[:result] == "WIN" && game_team[:team_id] == search_team_id
          all_win_info << game_team[:game_id]
        end
      end
    all_win_info = (all_win_info.count.to_f / @data_warehouse.game_teams.count.to_f).round(2)
  end

  def most_goals_scored(search_team_id)
    data = @data_warehouse
    team_stats = TeamStats.new(data)
    team_stats.most_goals_scored(search_team_id)
  end

  def fewest_goals_scored(search_team_id)
    data = @data_warehouse
    team_stats = TeamStats.new(data)
    team_stats.fewest_goals_scored(search_team_id)
  end

  def favorite_opponent(search_team_id)
    data = @data_warehouse
    team_stats = TeamStats.new(data)
    team_stats.favorite_opponent(search_team_id)
  end

  def rival(search_team_id)
    data = @data_warehouse
    team_stats = TeamStats.new(data)
    team_stats.rival(search_team_id)
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
