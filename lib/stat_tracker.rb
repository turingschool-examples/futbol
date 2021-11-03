require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_results
  def initialize(games, teams, game_results)
    @games      = games
    @teams      = teams
    @game_results = game_results
  end

  def self.from_csv(locations)
    games = CSV.parse(File.read(locations[:games]), headers: true)
    teams = CSV.parse(File.read(locations[:teams]), headers: true)
    game_results = CSV.parse(File.read(locations[:game_teams]), headers: true)
    ted_lasso = StatTracker.new(games, teams, game_results)
    return ted_lasso
  end

  def highest_total_score
    grouped_by_game = @game_results.group_by do |row|
      row["game_id"]
    end
    game_sum_goals = []
    grouped_by_game.each_pair do |key, value|
      first_team_goals = value.first["goals"].to_i
      second_team_goals = value.last["goals"].to_i
      game_sum_goals << first_team_goals + second_team_goals
    end
    game_sum_goals.max
  end

  def lowest_total_score
    grouped_by_game = @game_results.group_by do |row|
      row["game_id"]
    end
    game_sum_goals = []
    grouped_by_game.each_pair do |key, value|
      first_team_goals = value.first["goals"].to_i
      second_team_goals = value.last["goals"].to_i
      game_sum_goals << first_team_goals + second_team_goals
    end
    game_sum_goals.min
  end

  def percentage_home_wins
    
end
