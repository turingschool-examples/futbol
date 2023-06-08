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

  def create_season_hash(game_path)
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
    stat_tracker.create_season_hash(game_path)
    stat_tracker.create_game_teams(game_teams_path)
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

  def best_offense
    grouped_by_team = @game_teams.group_by do |team|
      team[:team_id]
    end
    #grouped_by_team should be a hash with keys of team, and values of their game data {team_id: [all the games]}
    #map the game data to be an average of their scores
    #return the team_id with highest value in hash
    #match team_id against team list to get name
  end
end