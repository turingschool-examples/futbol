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

  def sum_game_goals(season = nil)
    game_goals_hash = {}
    season_games = filter_by_season(season)
    season_games.each do |game|
      game_goals_hash[game.game_id] = (game.away_goals + game.home_goals)
    end
    game_goals_hash
  end

  def filter_by_season(season)
    @games.find_all do |game|
      game.season == season
    end
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
    find_percent(total_team_wins(team_id, season), count_of_games_by_season)
  end

  def team_ids
    @teams.map do |team|
      team.team_id
    end.sort
  end

  def all_teams_win_percentage(season)
    percent_wins = {}
    team_ids.each do |team_id|
      percent_wins[team_id] = season_win_percentage(team_id, season)
    end
    percent_wins
  end

  def winningest_team(season)
    all_teams_win_percentage(season).max_by do |team_id, win_percentage|
      win_percentage
    end.first
  end

# ~~~ Game Methods ~~~
  def lowest_total_score(season)
    sum_game_goals(season).min_by do |game_id, score|
      score
    end.last
  end

  def highest_total_score(season)
    sum_game_goals(season).max_by do |game_id, score|
      score
    end.last
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

  def winningest_coach(season)
    @game_teams.find do |game_team|
      game_team.team_id == winningest_team(season)
    end.head_coach 
  end

# ~~~ TEAM METHODS~~~

end
