require 'csv'
require_relative 'game'
require_relative 'game_manager'
require_relative 'game_team_manager'
require_relative 'game_team'
require_relative 'team'
require_relative 'team_manager'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams, locations)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_manager = GameManager.new(locations[:games], self)
    @game_team_manager = GameTeamManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams, locations)
  end
  #-------traffic cop methods-------#
  def find_winningest_coach(game_ids, expected_result)
    @game_team_manager.find_winningest_coach(game_ids, expected_result)
  end

  def find_worst_coach(game_ids)
    @game_team_manager.find_worst_coach(game_ids)
  end
  #-----end traffic cop methods-----#
  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.percentage_visitor_wins
  end

  def percentage_ties
    @game_manager.percentage_ties
  end

  def count_of_games_by_season
    @game_manager.count_of_games_by_season
  end

  def average_goals_per_game
    @game_manager.average_goals_per_game
  end

  def average_goals_by_season
    @game_manager.average_goals_by_season
  end

  def count_of_teams
    @team_manager.count_of_teams
  end

  def best_offense
    @game_team_manager.best_offense
  end

  def get_team_name(team_id)
    @team_manager.get_team_name(team_id)
  end

  def worst_offense
    @game_team_manager.worst_offense
  end

  def highest_scoring_visitor
    @game_manager.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_manager.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_manager.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_manager.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @game_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_manager.worst_coach(season)
  end

  def get_season_game_ids(season)
    @game_manager.get_season_game_ids(season)
  end

  def most_accurate_team(season)
    @game_team_manager.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_team_manager.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_team_manager.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_team_manager.fewest_tackles(season)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def best_season(team_id)
    @game_manager.best_season(team_id)
  end

  def worst_season(team_id)
    @game_manager.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    max_goals = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    high_goals = max_goals.max_by do |game|
      game["goals"]
    end
    high_goals["goals"].to_i
  end

  def fewest_goals_scored(team_id)
    min_goals = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    low_goals = min_goals.min_by do |game|
      game["goals"]
    end
    low_goals["goals"].to_i
  end

  def favorite_opponent(team_id)
    games = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    game_ids = games.map do |game|
      game["game_id"]
    end
    total_games = Hash.new(0)
    loser_loses = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"]) && game["team_id"] != team_id
        total_games[game["team_id"]]  += 1
        if game["result"] == "LOSS"
          loser_loses[game["team_id"]] += 1
        end
      end
    end
    biggest_loser = loser_loses.max_by do |loser, losses|
      losses.to_f / total_games[loser]
    end
    biggest_loser_name = @teams.find do |team|
      biggest_loser[0] == team["team_id"]
    end
    biggest_loser_name["teamName"]
  end

  def rival(team_id)
    games = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    game_ids = games.map do |game|
      game["game_id"]
    end
    total_games = Hash.new(0)
    winner_wins = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"]) && game["team_id"] != team_id
        total_games[game["team_id"]]  += 1
        if game["result"] == "WIN"
          winner_wins[game["team_id"]] += 1
        end
      end
    end
    biggest_winner = winner_wins.max_by do |winner, wins|
      wins.to_f / total_games[winner]
    end
    biggest_winner_name = @teams.find do |team|
      biggest_winner[0] == team["team_id"]
    end
    biggest_winner_name["teamName"]
  end
end
