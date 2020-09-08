require "csv"
require "./lib/team"
require "./lib/game"
require "./lib/game_team"

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations = {games: './data/games_sample.csv', teams: './data/teams_sample.csv', game_teams: './data/game_teams_sample.csv'})
    Game.from_csv(locations[:games])
    Team.from_csv(locations[:teams])
    GameTeam.from_csv(locations[:game_teams])
    self.new(Team.all_teams, Game.all_games, GameTeam.all_game_teams)
  end

# ~~~ Helper Methods ~~~~

  def total_games(filtered_games = @games)
    filtered_games.count
  end

  def find_percent(numerator, denominator)
    (numerator.count / denominator.to_f * 100).round(2)
  end

  def sum_game_goals
    game_goals_hash = {}
    @games.each do |game|
      game_goals_hash[game.game_id] = (game.away_goals + game.home_goals)
    end
    game_goals_hash
  end

  def wd_total_goals(filtered_games = @games)
    filtered_games.reduce(0) do |sum, game|
      sum += (game.home_goals + game.away_goals)
    end
  end

  def ratio (numerator, denominator)
    (numerator.to_f / denominator).round(2)
  end

# ~~~ Game Methods ~~~
  def lowest_total_score
    sum_game_goals.min_by do |game_id, score|
      score
    end.last
  end

  def highest_total_score
    sum_game_goals.max_by do |game_id, score|
      score
    end.last
  end

  def percentage_away_wins
    wins = @games.find_all { |game| game.away_goals > game.home_goals}
    find_percent(wins, total_games)
  end

  def percentage_ties
    ties = @games.find_all { |game| game.away_goals == game.home_goals}
    find_percent(ties, total_games)
  end

  def percentage_home_wins
    wins = @games.find_all { |game| game.away_goals < game.home_goals}
    find_percent(wins, total_games)
  end

# ~~~ LEAGUE METHODS~~~

# ~~~ SEASON METHODS~~~

# ~~~ TEAM METHODS~~~


  def seasonal_game_data
    seasonal_game_data = @games.group_by do |row|
      row.season
    end
    seasonal_game_data
  end

  def avg_goals_by_season
    avg_goals_by_season = {}
    seasonal_game_data.each do |season, details|
      avg_goals_by_season[season] = ratio(wd_total_goals(details), total_games(details))
    end
    avg_goals_by_season
  end

  def avg_goals_per_game
    ratio(wd_total_goals, total_games)
  end

end
