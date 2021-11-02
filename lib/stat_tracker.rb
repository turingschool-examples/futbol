require 'csv'
# require_relative './teams'
# require_relative './game_teams'
# require_relative './games'

require_relative './teams_test'
require_relative './game_teams_test'
require_relative './games_test'

class StatTracker
  attr_accessor :games, :teams, :game_teams

  def initialize()
    @games = []
    @teams = []
    @game_teams = []
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new()
    rows = CSV.read(locations[:teams], headers: true)
    rows.each do |row|
      team = Teams.new(row)
      stat_tracker.teams << team
    end

    rows = CSV.read(locations[:games], headers: true)
    rows.each do |row|
      games = Games.new(row)
      stat_tracker.games << games
    end

    rows = CSV.read(locations[:game_teams], headers: true)
    rows.each do |row|
      game_teams = GameTeams.new(row)
      stat_tracker.game_teams << game_teams
    end
    return stat_tracker
  end

  #Game Statistics Methods
  def highest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.max
  end

  def lowest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.min
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.each do |game|
      if game.away_goals > game.home_goals
        visitor_wins.push(game)
      end
    end
    (visitor_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      if game.home_goals > game.away_goals
        home_wins.push(game)
      end
    end
    (home_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    tie_games = []
    @games.each do |game|
      if game.home_goals == game.away_goals
        tie_games.push(game)
      end
    end
    (tie_games.count.to_f / @games.count.to_f).round(2)
  end

  # Average number of goals scored in a game across all seasons including
  # both home and away goals (rounded to the nearest 100th) - float
  def avg_goals_per_game
    total_goals = @games.map{|game| game.home_goals + game.away_goals}
    avg_goals_per_game = (total_goals.sum.to_f/total_goals.length.to_f).round(2)
  end

  # Average number of goals scored in a game organized in a hash
  # with season names (e.g. 20122013) as keys and a float
  # representing the average number of goals in a game for that season
  # as values (rounded to the nearest 100th)	- Hash
  def avg_goals_per_season
    avg_goals_per_season = Hash.new(0)
    games_by_season = @games.groupby do|game|
      game.season
    end
    games_by_season.keys.each do |season|
      goals_by_season = games_by_season[season].map{|game| game.home_goals + game.away_goals}
      avg_goals_per_season[season] = (goals_by_season.sum / goals_by_season.length).round(2)
    end
  end
end
