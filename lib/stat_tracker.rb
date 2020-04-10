require 'csv'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    GameTeam.from_csv(game_teams_path)
    Team.from_csv(teams_path)

    @games = Game.all
    @teams = Team.all
    @game_teams = GameTeam.all
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (away_wins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_ties
    ties = @game_teams.find_all {|team| team.result == "TIE"}
    (ties.length.to_f / @game_teams.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    games_by_season.transform_values {|season| season.length}
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game| game.away_goals + game.home_goals
    end
    highest_scoring_game.away_goals + highest_scoring_game.home_goals
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game| game.away_goals + game.home_goals
    end
    lowest_scoring_game.away_goals + lowest_scoring_game.home_goals
  end

  def average_goals_per_game
    sum_of_goals = @games.sum do |game|
      game.home_goals + game.away_goals
    end
    (sum_of_goals.to_f / @games.length).round(2)
  end

  def sum_of_goals_in_a_season(season)
    full_season = @games.find_all do |game|
      game.season == season
    end
    full_season.sum do |game|
      game.home_goals + game.away_goals
    end
  end

  def average_of_goals_in_a_season(season)
    by_season = @games.find_all do |game|
      game.season == season
    end
    (sum_of_goals_in_a_season(season).to_f / by_season.length).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = @games.group_by do |game|
      game.season
    end
    average_goals_by_season.transform_values do |season|
      average_of_goals_in_a_season(season.first.season)
    end
  end

  def count_of_teams
    @teams.length
  end

  def average_goals_by_team(team_id, hoa = nil)
    goals = 0
    games = 0
    @game_teams.each do |game_team|
      if hoa != nil
        if game_team.team_id == team_id && game_team.hoa == hoa
          goals += game_team.goals
          games += 1
        end
      elsif game_team.team_id == team_id
          goals += game_team.goals
          games += 1
      end
    end
    return 0 if games == 0
    (goals.to_f / games.to_f).round(2)
  end

  def unique_team_ids
    @game_teams.uniq { |game_team| game_team.team_id }.map{ |game_team| game_team.team_id }
  end

  def team_by_id(team_id)
    @teams.find { |team| team.team_id == team_id }
  end

  def best_offense
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def worst_offense
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def highest_scoring_visitor
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def highest_scoring_home_team
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def lowest_scoring_visitor
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def lowest_scoring_home_team
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def most_accurate_team(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.max_by {|team, acc| acc}[0]}.team_name
  end

  def least_accurate_team(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.min_by {|team, acc| acc}[0]}.team_name
  end

  def winningest_coach(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.max_by {|coach, wins| wins}[0]
  end

  def worst_coach(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.min_by {|coach, wins| wins}[0]
  end

  def most_tackles(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.max_by {|team, tack| tack}[0]}.team_name
  end

  def fewest_tackles(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    team_performances = @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.min_by {|team, tack| tack}[0]}.team_name
  end
end
