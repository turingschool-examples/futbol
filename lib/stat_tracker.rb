require "csv"
require_relative "./team"
require_relative "./game"
require_relative "./game_team"

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

  def season_group
    @games.group_by do |row|
      row.season
    end
  end

  def total_scores_by_team
    base = Hash.new(0)
    @game_teams.each do |game|
      key = game.team_id.to_s
      base[key] += game.goals
    end
    base
  end

  def average_scores_by_team
    total_scores_by_team.merge(games_containing_team){|team_id, scores, games_played| (scores.to_f / games_played).round(2)}
  end

  def games_containing_team
    games_by_team = Hash.new(0)
    @game_teams.each do |game|
      games_by_team[game.team_id.to_s] += 1
    end
    games_by_team
  end

  def team_names_by_team_id(id)
    team_id_hash = {}
    @teams.each do |team|
      team_id_hash[team.team_id.to_s] = team.team_name
    end
    team_id_hash[id.to_s]
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

  def worst_team(season)
    all_teams_win_percentage(season).min_by do |team_id, win_percentage|
      win_percentage
    end.first
  end

  def game_ids_per_season(season)
    specific_season = season_group[season]
    specific_season.map do |games|
      games.game_id
    end
  end

  def find_game_teams(game_ids)
    game_ids.flat_map do |game_id|
      @game_teams.find_all do |game|
        game_id == game.game_id
      end
    end
  end

  def shots_per_team_id(season)
    game_search = find_game_teams(game_ids_per_season(season))
    game_search.reduce(Hash.new(0)) do |results, game|
      results[game.team_id.to_s] += game.shots
      results
    end
  end

  def season_goals(season)
    specific_season = season_group[season]
    specific_season.reduce(Hash.new(0)) do |season_goals, game|
      season_goals[game.away_team_id.to_s] += game.away_goals
      season_goals[game.home_team_id.to_s] += game.home_goals
      season_goals
    end
  end

  def shots_per_goal_per_season(season)
    season_goals(season).merge(shots_per_team_id(season)) do |team_id, goals, shots|
      (shots.to_f / goals).round(2)
    end
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
    find_percent(total_team_wins(team_id, season), count_of_games_by_season[season])
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

  def count_of_games_by_season
    count = {}
    season_group.each do |season, games|
      count[season] = games.count
    end
    count
  end

# ~~~ LEAGUE METHODS~~~
  def worst_offense
    worst = average_scores_by_team.min_by {|id, average| average}
    team_names_by_team_id(worst[0])
  end

  def best_offense
    best = average_scores_by_team.max_by {|id, average| average}
    team_names_by_team_id(best[0])
  end

# ~~~ SEASON METHODS~~~

  def most_accurate_team(season)
    most_accurate = shots_per_goal_per_season(season).min_by { |team, avg| avg}
    team_names_by_team_id(most_accurate[0])
  end

  def least_accurate_team(season)
    least_accurate = shots_per_goal_per_season(season).max_by { |team, avg| avg}
    team_names_by_team_id(least_accurate[0])
  end

# ~~~ TEAM METHODS~~~

end
