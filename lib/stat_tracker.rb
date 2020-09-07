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
  def total_games
    @games.count
  end

  def find_percent(numerator, denominator)
    (numerator / denominator.to_f * 100).round(2)
  end

  def sum_game_goals
    game_goals_hash = {}
    @games.each do |game|
      game_goals_hash[game.game_id] = (game.away_goals + game.home_goals)
    end
    game_goals_hash
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

  def team_wins_as_home(team_id, season)
    @games.find_all do |game|
      game.home_team_id == team_id && game.home_goals > game.away_goals && game.season == season
    end.count
  end

  def team_wins_as_away(team_id, season)
    @games.find_all do |game|
      game.away_team_id == team_id && game.away_goals > game.home_goals
    end.count
  end

  def total_team_wins(team_id, season)
    team_wins_as_home(team_id, season) + team_wins_as_away(team_id, season)
  end

  def season_win_percentage(team_id, season)
    find_percent(total_team_wins, count_of_games_by_season.count)
  end

  def percentage_away_wins
    wins = @games.find_all { |game| game.away_goals > game.home_goals}
    find_percent(wins.count, total_games)
  end

  def percentage_ties
    ties = @games.find_all { |game| game.away_goals == game.home_goals}
    find_percent(ties.count, total_games)
  end

  def percentage_home_wins
    wins = @games.find_all { |game| game.away_goals < game.home_goals}
    find_percent(wins.count, total_games)
  end

# ~~~ LEAGUE METHODS~~~

# ~~~ SEASON METHODS~~~

# ~~~ TEAM METHODS~~~

end
