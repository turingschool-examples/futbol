require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      game = Game.new(row)
      games << game
    end
    teams = []
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
      teams << team
    end
    game_teams = []
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end

    stat_tracker = StatTracker.new(games, teams, game_teams)
  end

  # Game Statistics
  def highest_total_score
    high_score = 0
    @games.each do |game|
      if game.total_goals > high_score
        high_score = game.total_goals
      end
    end
    high_score
  end

  def lowest_total_score
    low_score = 100
    @games.each_value do |game|
      if game.total_goals < low_score
        low_score = game.total_goals
      end
    end
    low_score
  end

  def total_games_count
    @games.length.to_f
  end

  def home_wins_count
    home_wins_count = 0.0
    @games.each do |game|
      if game.home_win?
        home_wins_count += 1
      end
    end
    home_wins_count
  end

  def percentage_home_wins
    percentage_home_wins = (home_wins_count / total_games_count) * 100
    percentage_home_wins.round(2)
  end

  def visitor_wins_count
    visitor_wins_count = 0.0
    @games.each do |game|
      if game.visitor_win?
        visitor_wins_count += 1
      end
    end
    visitor_wins_count
  end

  def percentage_visitor_wins
    percentage_visitor_wins = (visitor_wins_count / total_games_count) * 100

    percentage_visitor_wins.round(2)
  end

  def tied_games_count
    tied_games_count = 0.0
    @games.each do |game|
      if game.tie_game?
        tied_games_count += 1
      end
    end
    tied_games_count
  end

  def percentage_ties
    percentage_ties = (tied_games_count / total_games_count) * 100

    percentage_ties.round(2) #create a module that rounds all floats to 2 decimal places?
  end

  def total_goals
    total_goals_count = 0.0
    @games.each do |game|
      total_games_count += game.total_goals
    end
    total_goals_count
  end

  def average_goals_per_game
    avg_goals = total_goals / total_games_count
    avg_goals.round(2)
  end
  # League Statistics


  # Season Statistics


  # Team Statistics



end
