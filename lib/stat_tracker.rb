require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'season_stats'
require_relative 'team_stats'
require_relative 'league_stats'
require_relative 'game_stats'
#require 'pry'

class StatTracker

  attr_reader :game_stats, :league_stats, :season_stats, :team_stats

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    Team.from_csv(teams_path)
    GameTeam.from_csv(game_teams_path)

    @game_stats = GameStats.new(Game.all, Team.all, GameTeam.all)
    @league_stats = LeagueStats.new(Game.all, Team.all, GameTeam.all)
    @season_stats = SeasonStats.new(Game.all, Team.all, GameTeam.all)
    @team_stats = TeamStats.new(Game.all, Team.all, GameTeam.all)
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

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
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

  def average_goals_by_team(team_id, hoa = nil)
    @league_stats.average_goals_by_team(team_id, hoa = nil)
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

  def winningest_coach(season)
    @season_stats.winningest_coach(season)
  end

  def worst_coach(season)
    @season_stats.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_stats.fewest_tackles(season)
  end

  def team_info(team_id)
      # team = team_by_id(team_id)
      # team_data = team.instance_variables.map { |key,value| ["#{key}".delete("@"), value = team.send("#{key}".delete("@").to_sym)]}.to_h
      # team_data.delete_if {|k,v| k == "stadium"}
    @team_stats.team_info(team_id)
  end

  def best_season(team_id)
    # team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
    # seasons = team_seasons.group_by {|game| game.season}
    # seasons.each do |season, season_games|
    #   season_game_ids = season_games.map{|game| game.game_id}
    #   team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
    #   seasons[season] = calculate_win_percentage(team_games)
    # end
    # seasons.max_by { |season, win_pct| win_pct }[0]
    @team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    # team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
    # seasons = team_seasons.group_by {|game| game.season}
    # seasons.each do |season, season_games|
    #   season_game_ids = season_games.map{|game| game.game_id}
    #   team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
    #   seasons[season] = calculate_win_percentage(team_games)
    # end
    # seasons.min_by { |season, win_pct| win_pct }[0]
    @team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    # team_games = all_games_by_team(team_id)
    # calculate_win_percentage(team_games).round(2)
    @team_stats.average_win_percentage(team_id)
  end

  # def all_games_by_team(team_id)
  #   @game_teams.find_all{|game_team| game_team.team_id == team_id}
  # end

  def most_goals_scored(team_id)
    # all_games_by_team(team_id).max_by{|game| game.goals}.goals
    @team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    # all_games_by_team(team_id).min_by{|game| game.goals}.goals
    @team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    # team_games = all_games_by_team(team_id)
    # team_games.map! {|game| game.game_id}
    # opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
    # opp_teams = opp_team_games.group_by {|game| game.team_id}
    # win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
    # @teams.find {|team| team.team_id == win_pct_against.max_by {|team, win_pct| win_pct}[0]}.team_name
    @team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    # team_games = all_games_by_team(team_id)
    # team_games.map! {|game| game.game_id}
    # opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
    # opp_teams = opp_team_games.group_by {|game| game.team_id}
    # win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
    # @teams.find {|team| team.team_id == win_pct_against.min_by {|team, win_pct| win_pct}[0]}.team_name
    @team_stats.rival(team_id)
  end

  # def calculate_win_percentage(team_games)
  #   wins = 0.0
  #   team_games.each {|game| wins += 1.0 if game.result == "WIN"}
  #   (wins / team_games.length)
  # end

end
