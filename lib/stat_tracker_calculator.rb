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
  
  # def avg_goals_by_team(team_id)
  #   goals_per_game = []
  #   @game_factory.games.each do |game|
  #     if game.away_team_id == team_id
  #       goals_per_game << game.away_goals
  #     elsif game.home_team_id == team_id
  #       goals_per_game << game.home_goals
  #     end
  #   end
  #   goals_per_game.sum.to_f / goals_per_game.count.to_f
  # end

  # def best_offense
  #   best_team = @game_factory.games.max_by do |game|
  #     avg_goals_by_team(game.away_team_id)
  #     avg_goals_by_team(game.home_team_id)
  #   end
  #     @team_factory.teams.select {|team| team.team_id == best_team.home_team_id}.first.team_name
  # end

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

#This two helper methods need tests and probably need to go in GameFactory class
  def goals_at_home(team_id)
    goals_at_home = []
    @game_factory.games.each do |game|
      goals_at_home << game.home_goals if game.home_team_id == team_id
    end
    goals_at_home
  end

  def goals_at_away(team_id)
    goals_at_away = []
    @game_factory.games.each do |game|
      goals_at_away << game.away_goals if game.away_team_id == team_id
    end
    goals_at_away
  end
#
  def highest_scoring_visitor
    #Name of the team with the highest average score per game across all seasons when they are away.
    @team_factory.teams.max_by do |team|
      (goals_at_away(team.team_id).sum.to_f) / (goals_at_away(team.team_id).count.to_f)
      end.team_name
  end
  
  def highest_scoring_home_team	
    #Name of the team with the highest average score per game across all seasons when they are home.
    @team_factory.teams.max_by do |team|
      (goals_at_home(team.team_id).sum.to_f) / (goals_at_home(team.team_id).count.to_f)
      end.team_name
  end

  def lowest_scoring_visitor	
    #Name of the team with the lowest average score per game across all seasons when they are a visitor.
    @team_factory.teams.min_by do |team|
      (goals_at_away(team.team_id).sum.to_f) / (goals_at_away(team.team_id).count.to_f)
      end.team_name
  end

  def lowest_scoring_home_team	
    #Name of the team with the lowest average score per game across all seasons when they are at home.
    @team_factory.teams.min_by do |team|
      (goals_at_home(team.team_id).sum.to_f) / (goals_at_home(team.team_id).count.to_f)
      end.team_name
  end
  
  def winningest_coach(season)
    season = season.to_i
    @game_teams_factory.win_percentage_by_coach_by_season(season).max_by do |coach, percentage|
      percentage
    end.first
    # Name of the Coach with the best win percentage for the season
  end

  def worst_coach(season)	
    # Name of the Coach with the worst win percentage for the season
    season = season.to_i
    @game_teams_factory.win_percentage_by_coach_by_season(season).min_by do |coach, percentage|
      percentage
    end.first
  end

  def most_accurate_team(season)
    #Name of the Team with the best ratio of shots to goals for the season
    season = season.to_i   
    team_id = @game_teams_factory.ratio_of_shots_to_goals_by_season(season).max_by do |team_id, percentage| 
      percentage
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def least_accurate_team(season)
    # Name of the Team with the worst ratio of shots to goals for the season
    season = season.to_i   
    team_id = @game_teams_factory.ratio_of_shots_to_goals_by_season(season).min_by do |team_id, percentage| 
      percentage
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def most_tackles(season)
    #Name of the Team with the most tackles in the season
    season = season.to_i   
    team_id = @game_teams_factory.tackles_by_season(season).max_by do |team_id, amount| 
      amount
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

  def fewest_tackles(season)
    #Name of the Team with the fewest tackles in the season	String
    season = season.to_i   
    team_id = @game_teams_factory.tackles_by_season(season).min_by do |team_id, amount| 
      amount
    end.first
    @team_factory.teams.select {|team| team.team_id == team_id}.first.team_name 
  end

end