require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'season'
require_relative 'team_accuracy'
require_relative 'tackle_counter'
require_relative 'statistics_generator'
require_relative 'team_season_evaluator'
require_relative 'offensive'


class StatTracker < StatisticsGenerator
  include TeamAccuracy
  include TackleCounter
  include TeamSeasonEvaluator
  include Offensive

  def initialize(data)
    super(data)
  end

  def percentage_home_wins
    home_teams = @game_teams.select do |team|
      team.hoa == "home"
    end
    winning_teams = home_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / home_teams.count.to_f
    percentage_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_teams = @game_teams.select do |team|
      team.hoa == "away"
    end
    winning_teams = visitor_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / visitor_teams.count.to_f
    percentage_wins.round(2)
  end
  
  def percentage_ties
    games_tied = @game_teams.select do |game|
      game.result == "TIE"
    end
    games_tied_float = games_tied.count / @game_teams.count.to_f
    games_tied_float.round(2)
  end

  def highest_total_score
    highest_goal = @games.max_by do |game|
      game.away_goals + game.home_goals 
    end
    highest_goal.away_goals + highest_goal.home_goals
  end

  def lowest_total_score
    lowest_goals = @games.min_by do |game|
      game.away_goals + game.home_goals 
    end
    lowest_goals.away_goals + lowest_goals.home_goals
  end

  def average_goals_per_game
    averages = offensive("home", "away").values
    ((averages.sum / averages.count.to_f) * 2).round(2) 
  end

  def count_of_teams
    @teams.count
  end

  def winningest_coach(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
      if coach == won_coach
        coach_win_percentage[coach] = (won_games / games.to_f)
        end
      end
    end
    coach_win_percentage.max_by {|coach, percentage| percentage}[0]
  end
  
  def count_of_games_by_season
    games_count = {}
    @seasons_by_id.keys.map do |season_id| 
      games_count[season_id] = @seasons_by_id[season_id][:games].length
    end
    games_count
  end

  def average_goals_by_season
    goals = Hash.new(0)
    @seasons_by_id.each do |season, season_info|
        goals[season] = (season_info[:game_teams].sum{|game_team| game_team.goals.to_f} / 
                        (season_info[:game_teams].length / 2).to_f).round(2)
    end
    goals
  end

  def most_accurate_team(season_id)
    @teams.find{|team| team.team_id == find_accuracy_ratios(season_id).max_by{|team,ratio| ratio}.first}.teamname 
  end

  def least_accurate_team(season_id)
    @teams.find{|team| team.team_id == find_accuracy_ratios(season_id).min_by{|team,ratio| ratio}.first}.teamname
  end

  def worst_coach(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
        if coach == won_coach
          coach_win_percentage[coach] = (won_games / games.to_f)
        end
        if !games_won_coach.include?(coach)
          coach_win_percentage[coach] = 0
        end
      end
    end
    coach_win_percentage.min_by {|coach, percentage| percentage}[0]
  end
  
  def best_offense 
    best_offense = offensive("away", "home").max_by {|id,avg_goals| avg_goals} 
    @teams.find {|team| team.team_id == best_offense.first}.teamname
  end
  
  def worst_offense 
    worst_offense = offensive("away", "home").min_by {|id,avg_goals| avg_goals} 
    @teams.find {|team| team.team_id == worst_offense.first}.teamname
  end
  
  def highest_scoring_home_team
    highest_home = offensive("home").max_by {|id,avg_goals| avg_goals} 
    @teams.find {|team| team.team_id == highest_home.first}.teamname
  end  
  
  def lowest_scoring_home_team
    lowest_visitor = offensive("home").min_by {|id,avg_goals| avg_goals}
    @teams.find {|team| team.team_id == lowest_visitor.first}.teamname
  end

  def highest_scoring_visitor
    highest_visitor = offensive("away").max_by {|id,avg_goals| avg_goals} 
    @teams.find {|team| team.team_id == highest_visitor.first}.teamname
  end  

  def lowest_scoring_visitor
    lowest_visitor = offensive("away").min_by {|id,avg_goals| avg_goals}
    @teams.find {|team| team.team_id == lowest_visitor.first}.teamname
  end

  def most_tackles(season_id)
    @teams.find{|team| team.team_id == count_tackles(season_id).max_by {|team_id, tackles| tackles}.first}.teamname
  end

  def fewest_tackles(season_id)
    @teams.find{|team| team.team_id == count_tackles(season_id).min_by {|team_id, tackles| tackles}.first}.teamname
  end

#best_and_worst_season_db
  def best_season(team_id)
    evaluate_seasons(team_id).max_by{|season, average| average}.first
  end

  def worst_season(team_id)
    evaluate_seasons(team_id).min_by{|season, average| average}.first
  end

  def team_info(team_id)
    team_identifiers = {}
    this_team = @teams.find{|team| team.team_id == team_id}
    this_team.instance_variables.each do |variable|
      team_identifiers[variable.to_s.delete("@")] = this_team.instance_variable_get(variable)
    end
    team_identifiers.delete("stadium")
    team_identifiers["team_name"] = team_identifiers.delete("teamname")
    team_identifiers["franchise_id"] = team_identifiers.delete("franchiseid")
    team_identifiers
  end
end

