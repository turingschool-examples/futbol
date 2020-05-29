
require "csv"
require "./lib/game_collection"
require "./lib/team_collection"
require "./lib/game_team_collection"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  # Game statistics
  def highest_total_score
    games.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_score
    games.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def percentage_home_wins
    home_win_total = games.find_all do |game|
      game.home_goals > game.away_goals
    end.count.to_f
    (home_win_total / games.count).round(2)
  end

  
end
