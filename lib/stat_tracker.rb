require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol)
    stats_tracker = StatTracker.new(games_input, teams_input, game_teams_input)
  end

  def count_of_games_by_season
    games[:season].tally
  end

  def average_goals_per_game
    total_goals = @games[:away_goals].map(&:to_i).sum.to_f + @games[:home_goals].map(&:to_i).sum
    total_games = @games.length
    (total_goals / total_games).round(2)
  end

  def average_goals_by_season
    season_goal_averages = Hash.new(0)
    
  end
  
end
