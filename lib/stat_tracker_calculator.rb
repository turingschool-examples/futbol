require_relative './game'
require_relative './game_factory'
require_relative './team'
require_relative './team_factory'
require_relative './game_teams'
require_relative './game_teams_factory'
class StatTrackerCalculator
  attr_reader :game_factory,
              :team_factory,
              :game_teams_factory

  def initialize
    @game_factory = ""
    @team_factory = ""
    @game_teams_factory = ""
  end

  def highest_total_score
    @game_factory.total_score.max
  end

  def lowest_total_score
    @game_factory.total_score.min
  end

  def percentage_home_wins
    (@game_teams_factory.game_result_by_hoa.count {|result| result == "home"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (@game_teams_factory.game_result_by_hoa.count {|result| result == "away"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_ties
    (@game_teams_factory.game_results_count_by_result("TIE").to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    @game_factory.games.each do |game|
      count_of_games_by_season[game.season] = @game_factory.season_games(game.season)
    end
    count_of_games_by_season
  end

  def average_goals_per_game
    (@game_factory.total_score.sum.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = {}
    @game_factory.games.each do |game|
      average_goals_by_season[game.season] = ((@game_factory.count_of_goals(game.season).to_f)/(@game_factory.season_games(game.season))).round(2)
    end
    average_goals_by_season
  end

  def count_of_teams
    @team_factory.teams.size
  end

  def best_offense
    best_team = @game_factory.games.max_by do |game|
      @game_factory.avg_goals_by_team(game.away_team_id)
      @game_factory.avg_goals_by_team(game.home_team_id)
    end
      @team_factory.teams.select {|team| team.team_id == best_team.home_team_id}.first.team_name
  end

  def worst_offense
    worst_team = @game_factory.games.min_by do |game|
      @game_factory.avg_goals_by_team(game.away_team_id)
      @game_factory.avg_goals_by_team(game.home_team_id)
    end
      @team_factory.teams.select {|team| team.team_id == worst_team.home_team_id}.first.team_name
  end

  def highest_scoring_visitor
    @team_factory.teams.max_by do |team|
      (goals_at_away(team.team_id).sum.to_f) / (goals_at_away(team.team_id).count.to_f)
      end.team_name
  end
  
  def highest_scoring_home_team	
    @team_factory.teams.max_by do |team|
      (goals_at_home(team.team_id).sum.to_f) / (goals_at_home(team.team_id).count.to_f)
      end.team_name
  end

  def lowest_scoring_visitor	
    @team_factory.teams.min_by do |team|
      (goals_at_away(team.team_id).sum.to_f) / (goals_at_away(team.team_id).count.to_f)
      end.team_name
  end

  def lowest_scoring_home_team	
    @team_factory.teams.min_by do |team|
      (goals_at_home(team.team_id).sum.to_f) / (goals_at_home(team.team_id).count.to_f)
      end.team_name
  end
  
  def winningest_coach(season)
    season = season.to_i
    @game_teams_factory.win_percentage_by_coach_by_season(season).max_by do |coach, percentage|
      percentage
    end.first
  end

  def worst_coach(season)	
    season = season.to_i
    @game_teams_factory.win_percentage_by_coach_by_season(season).min_by do |coach, percentage|
      percentage
    end.first
  end

  def most_accurate_team(season)
    season = season.to_i   
    team_id = @game_teams_factory.ratio_of_shots_to_goals_by_season(season).max_by do |team_id, percentage| 
      percentage
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def least_accurate_team(season)
    season = season.to_i   
    team_id = @game_teams_factory.ratio_of_shots_to_goals_by_season(season).min_by do |team_id, percentage| 
      percentage
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def most_tackles(season)
    season = season.to_i   
    team_id = @game_teams_factory.tackles_by_season(season).max_by do |team_id, amount| 
      amount
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def fewest_tackles(season)
    season = season.to_i   
    team_id = @game_teams_factory.tackles_by_season(season).min_by do |team_id, amount| 
      amount
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

end