require './lib/game'
require './lib/modules/calculable'
require './lib/modules/hashable'

class LeagueStatistics
  include Calculable
  include Hashable

  def initialize
    @teams = Team.all
    @games = Game.all
    @game_teams = GameTeam.all
  end

  def count_of_teams
    @teams.size
  end

  def find_team_names(team_id)
    match_team = @teams.find do |team|
      team.team_id == team_id
    end
    match_team.team_name
  end

  def goals_per_team
    @game_teams.reduce({}) do |goals_per_team, game_team|
      hash_builder(goals_per_team, game_team.team_id, game_team.goals)
    end
  end

  def average_goals_per_team
    goals_per_team.transform_values do |goals|
      average(goals.sum.to_f, goals.size)
    end
  end

  def best_offense
    find_team_names(hash_key_max_by(average_goals_per_team))
  end

  def worst_offense
    find_team_names(hash_key_min_by(average_goals_per_team))
  end

  def games_teams_and_allowed_goals
    @games.reduce({}) do |teams_allowed_goals, game|
      teams_allowed_goals[game.home_team_id] = [] if teams_allowed_goals[game.home_team_id].nil?
      teams_allowed_goals[game.away_team_id] = [] if teams_allowed_goals[game.away_team_id].nil?

      teams_allowed_goals[game.home_team_id] << game.away_goals
      teams_allowed_goals[game.away_team_id] << game.home_goals

      teams_allowed_goals
    end
  end

  def average_games_teams_and_allowed_goals
    games_teams_and_allowed_goals.transform_values do |allowed_goals|
      average(allowed_goals.sum.to_f, allowed_goals.size)
    end
  end

  def best_defense
    find_team_names(hash_key_min_by(average_games_teams_and_allowed_goals))
  end

  def worst_defense
    find_team_names(hash_key_max_by(average_games_teams_and_allowed_goals))
  end

  def visiting_teams_and_goals
    @games.reduce({}) do |visitor_games, game|
      hash_builder(visitor_games, game.away_team_id, game.away_goals)
    end
  end

  def average_visiting_teams_and_goals
    visiting_teams_and_goals.transform_values do |goals|
      average(goals.sum.to_f, goals.size)
    end
  end

  def highest_scoring_visitor
    find_team_names(hash_key_max_by(average_visiting_teams_and_goals))
  end

  def lowest_scoring_visitor
    find_team_names(hash_key_min_by(average_visiting_teams_and_goals))
  end

  def home_teams_and_goals
    @games.reduce({}) do |home_games, game|
      hash_builder(home_games, game.home_team_id, game.home_goals)
    end
  end

  def average_home_teams_and_goals
    home_teams_and_goals.transform_values do |goals|
      average(goals.sum.to_f, goals.size)
    end
  end

  def highest_scoring_home_team
    find_team_names(hash_key_max_by(average_home_teams_and_goals))
  end

  def lowest_scoring_home_team
    find_team_names(hash_key_min_by(average_home_teams_and_goals))
  end

  def game_team_results
    @game_teams.reduce({}) do |results_hash, game_team|
      hash_builder(results_hash, game_team.team_id, game_team.result)
    end
  end

  def percent_wins
    game_team_results.transform_values do |results|
      wins = (results.find_all { |result| result == "WIN"})
      percent(wins.length.to_f, results.length)
    end
  end

  def winningest_team
    find_team_names(hash_key_max_by(percent_wins))
  end
end
