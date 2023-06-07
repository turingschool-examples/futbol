require "csv"
require "./lib/game"
require "./lib/team"

class StatTracker
  attr_reader :games,
              :teams

  def initialize
    @games = []
    @teams = []
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
  
  def self.from_csv(game_path, teams_path, game_teams_path)
    stat_tracker = self.new
    stat_tracker.create_games(game_path)
    stat_tracker.create_teams(teams_path)
    stat_tracker
  end

  def highest_total_score
    highest_score = 0

    @games.each do |game|
      total_score = game.away_goals + game.home_goals
      highest_score = total_score if total_score > highest_score
    end

    highest_score
  end
end