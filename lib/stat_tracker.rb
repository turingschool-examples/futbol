require "csv"
require "./lib/game"
require "./lib/team"

class StatTracker
  attr_reader :games,
              :teams

  def initialize
    @games = []
    @teams = []
    @season_hash = {}
    @game_teams = []
    @grouped_game_teams = {}
  end
  
  def create_games(game_path)
    game_lines = CSV.open game_path, headers: true, header_converters: :symbol
    game_lines.each do |line|
      @games << Game.new(line)
    end
  end
  
  def create_teams(teams_path)
    teams_lines = CSV.open teams_path, headers: true, header_converters: :symbol
    teams_lines.each do |line|
      @teams << Team.new(line)
    end
  end

  def create_season_hash
    @season_hash = @games.group_by {|game| game.season}
  end

  def create_game_teams(game_teams_path)
    game_teams_lines = CSV.open game_teams_path, headers: true, header_converters: :symbol
    game_teams_lines.each do |line|
      @game_teams << GameTeam.new(line)
    end
  end
  
  def self.from_csv(game_path, teams_path, game_teams_path)
    stat_tracker = self.new
    stat_tracker.create_games(game_path)
    stat_tracker.create_teams(teams_path)
    stat_tracker.create_season_hash
    stat_tracker.create_game_teams(game_teams_path)
    stat_tracker.group_teams
    stat_tracker
  end

  def highest_total_score
    @games.max_by{|game| game.total_goals}.total_goals
  end

  def lowest_total_score
    @games.min_by{|game| game.total_goals}.total_goals
  end

  def percentage_home_wins
    home_wins = @games.count{|game| game.home_win?}
    total_games = @games.length
    (home_wins/total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count{|game| game.visitor_win?}
    total_games = @games.length
    (visitor_wins/total_games.to_f).round(2)
  end

  def percentage_ties
    ties = @games.count{|game| game.home_goals == game.away_goals}
    total_games = @games.length
    (ties/total_games.to_f).round(2)
  end 

  def count_of_games_by_season
    game_count = {}
    @season_hash.each do |season, games|
      game_count[season] = games.count
    end
    game_count
  end

  def average_goals_per_game
    average_goals = @games.map {|game| game.goals_averaged}
    (average_goals.sum.to_f/average_goals.count).round(2)
  end

  def average_goals_by_season
    goal_count = {}
    @season_hash.each do |season, games|
      averaged_goals = games.map {|game| game.goals_averaged}
      combined_average = (averaged_goals.sum.to_f/averaged_goals.count).round(2)
      goal_count[season] = combined_average
    end
    goal_count
  end

  def count_of_teams
    @teams.count
  end

  def group_teams
    @grouped_game_teams = @game_teams.group_by do |team|
      team.team_id
    end
  end
  #move into helper class?
  def offense_helper
    team_average_scores = {}
    @grouped_game_teams.each do |team, games|
      game_scores = games.map { |game| game.goals }
      average_goals = game_scores.sum.to_f/game_scores.length
      team_average_scores[team] = average_goals
    end
    team_average_scores
  end

  def best_offense
    top_team_array = offense_helper.max_by {|team, score| score}
    top_team_id = top_team_array[0].to_s
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def worst_offense
    worst_team_array = offense_helper.min_by {|team, score| score}
    worst_team_id = worst_team_array[0].to_s
    worst_team = @teams.find {|team| team.id == worst_team_id }
    worst_team.team_name
  end

  def highest_scoring_visitor
    @grouped_game_teams
    scores_when_visitor = {}
    @grouped_game_teams.each do |team, games|
      away_games = games.select {|game| game.home_or_away == "away"}
      scores = away_games.map { |game| game.goals }
      average_visitor_score = scores.sum.to_f/scores.length
      scores_when_visitor[team] = average_visitor_score
    end
    top_team_array = scores_when_visitor.max_by {|team, score| score}
    top_team_id = top_team_array[0].to_s
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end
end