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

# ~~~ HELPER METHODS~~~
  def total_games
    @games.count
  end

  def percent_wins_or_ties(numerator)
    (numerator.count / total_games.to_f * 100).round(2)
  end

# ~~~ GAME METHODS~~~
  def percentage_away_wins
    wins = @games.find_all { |game| game.away_goals > game.home_goals}
    percent_wins_or_ties(wins)
  end

  def percentage_ties
    ties = @games.find_all { |game| game.away_goals == game.home_goals}
    percent_wins_or_ties(ties)
  end

  def percentage_home_wins
    wins = @games.find_all { |game| game.away_goals < game.home_goals}
    percent_wins_or_ties(wins)
  end

# ~~~ LEAGUE METHODS~~~

# ~~~ SEASON METHODS~~~

# ~~~ TEAM METHODS~~~

end
