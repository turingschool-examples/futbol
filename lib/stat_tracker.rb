require "csv"
require "./lib/game"
require "./lib/team"

class StatTracker
  attr_reader :games,
              :teams

  def initialize
    @games = []
    @teams = []
    # @game_teams = []
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

  # def create_game_teams
  #   game_teams_lines = CSV.open game_path, headers: true, header_converters: :symbol
  #   game_teams_lines.each do |line|
  #     @game_teams << Game.new(line)
  # end
  
  def self.from_csv(game_path, teams_path, game_teams_path)
    stat_tracker = self.new
    stat_tracker.create_games(game_path)
    stat_tracker.create_teams(teams_path)
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
end