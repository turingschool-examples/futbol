require 'csv'
require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/league'
require './lib/object_generator'

class StatTracker
  include ObjectGenerator
  attr_reader :league

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    games = games_array_creator(locations[:games])
    teams = teams_array_creator(locations[:teams])
    game_teams = game_teams_array_creator(locations[:game_teams])
    @league = League.new(games, teams, game_teams)
  end

#Game Statistics Methods
  def highest_total_score
    @league.total_goals.max
  end

  def lowest_total_score
    @league.total_goals.min
  end

  def percentage_home_wins
    (@league.home_wins_counter.to_f / @league.all_games.count).round(2)
  end

  def percentage_visitor_wins
    (@league.visitor_wins_counter.to_f / @league.all_games.count).round(2)
  end

  def percentage_ties
    (@league.tie_counter.to_f / @league.all_games.count).round(2)
  end

  def count_of_games_by_season
    @league.games_by_season
  end

  def average_goals_per_game
    (@league.total_goals.sum(0.0) / @league.total_goals.length).round(2)
  end

  def average_goals_by_season
    @league.avg_goals_by_season
  end
  #League Statistics Methods
  def count_of_teams
    @league.team_names.count
  end

  def best_offense
    max = @league.avg_goals_by_team_id.max_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(max[0])
  end

  def worst_offense
    min = @league.avg_goals_by_team_id.min_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(min[0])
  end

  def highest_scoring_visitor
    max = @league.avg_away_team_by_goals.max_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(max[0])
  end

  def lowest_scoring_visitor
    min = @league.avg_away_team_by_goals.min_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(min[0])
  end

  def highest_scoring_home_team
    max = @league.avg_home_team_by_goals.max_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(max[0])
  end

  def lowest_scoring_home_team
    min = @league.avg_home_team_by_goals.min_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(min[0])
  end
#Season Statistics Methods
  def winningest_coach(season)
    @league.coaches_by_win_percentage(season).max_by do |coach, win_percentage|
      win_percentage
    end[0]
  end

  def worst_coach(season)
    @league.coaches_by_win_percentage(season).min_by do |coach, win_percentage|
      win_percentage
    end[0]
  end

  def most_accurate_team(season)
    team_id = @league.teams_by_accuracy(season).max_by do |team, accuracy|
      accuracy
    end[0]
    @league.team_id_to_team_name(team_id)
  end

  def least_accurate_team(season)
    team_id = @league.teams_by_accuracy(season).min_by do |team, accuracy|
      accuracy
    end[0]
    @league.team_id_to_team_name(team_id)
  end

  def most_tackles(season)
    team_id = @league.teams_by_tackles(season).max_by do |team, tackles|
      tackles
    end[0]
    @league.team_id_to_team_name(team_id)
  end

  def fewest_tackles(season)
    team_id = @league.teams_by_tackles(season).min_by do |team, tackles|
      tackles
    end[0]
    @league.team_id_to_team_name(team_id)
  end
#Team Statistics Methods
  def team_info(given_team_id)
    selected_team = @league.find_team(given_team_id)
    @league.display_team_info(selected_team)
  end

  def best_season(given_team_id)
    @league.seasons_by_wins(given_team_id).max_by do |season, win_percentage|
      win_percentage
    end[0]
  end

  def worst_season(given_team_id)
    @league.seasons_by_wins(given_team_id).min_by do |season, win_percentage|
      win_percentage
    end[0]
  end

  def average_win_percentage(team_id)
    (@league.team_wins(team_id).to_f / @league.team_total_games(team_id)).round(2)
  end

  def most_goals_scored(team_id)
    @league.goals_scored_in_game(team_id).max
  end

  def fewest_goals_scored(team_id)
    @league.goals_scored_in_game(team_id).min
  end

  def favorite_opponent(given_team_id)
    fav_opponent_team_id = @league.win_percentage_by_opponent(given_team_id).max_by do |opp, win_percentage|
      win_percentage
    end[0]
    @league.team_id_to_team_name(fav_opponent_team_id)
  end

  def rival(given_team_id)
    rival_team_id = @league.win_percentage_by_opponent(given_team_id).min_by do |opp, win_percentage|
      win_percentage
    end[0]
    @league.team_id_to_team_name(rival_team_id)
  end
end
