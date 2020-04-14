require 'csv'
require './lib/game_stats.rb'
require './lib/season_stats.rb'
require './lib/league_stats.rb'
require './lib/team_stats.rb'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'calculable'
require 'pry'

class StatTracker

  attr_reader :game_stats, :league_stats, :season_stats, :team_stats

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    GameTeam.from_csv(game_teams_path)
    Team.from_csv(teams_path)

    @game_stats = GameStats.new(Game.all, Team.all, GameTeam.all)
    @league_stats = LeagueStats.new(Game.all, Team.all, GameTeam.all)
    @season_stats = SeasonStats.new(Game.all, Team.all, GameTeam.all)
    @team_stats = TeamStats.new(Game.all, Team.all, GameTeam.all)
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties #game_teams
    @game_stats.percentage_ties
  end

  def count_of_games_by_season # game
    @game_stats.count_of_games_by_season
  end

  def highest_total_score # game
    @game_stats.highest_total_score
  end

  def lowest_total_score # game
    @game_stats.lowest_total_score
  end

  def average_goals_per_game # game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season # game
    @game_stats.average_goals_by_team
  end

  def count_of_teams
    @teams.length
  end

  def average_goals_by_team(team_id, hoa = nil) # game_teams?
    goals = total_games_and_goals_by_team(team_id, hoa)[0]
    games = total_games_and_goals_by_team(team_id, hoa)[1]
    return 0 if games == 0
    (goals.to_f / games.to_f).round(2) # average
  end

  def total_games_and_goals_by_team(team_id, hoa)
    goals_games = [0, 0]
    @game_teams.each do |game_team|
      if hoa && game_team.team_id == team_id && game_team.hoa == hoa
        add_goals_and_games(goals_games, game_team)
      elsif !hoa && game_team.team_id == team_id
        add_goals_and_games(goals_games, game_team)
      end
    end
    goals_games
  end

  def add_goals_and_games(goals_games, game_team)
    goals_games[0] += game_team.goals
    goals_games[1] += 1
  end

  def unique_team_ids # parent?
    @game_teams.map{|game_team| game_team.team_id}.uniq
  end

  def team_by_id(team_id) # parent class
    @teams.find{|team| team.team_id == team_id}
  end

  def best_offense
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def worst_offense
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def highest_scoring_visitor
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def highest_scoring_home_team
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def lowest_scoring_visitor
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def lowest_scoring_home_team
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def team_games_by_season(season) # test
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
  end

  # make a season class?

  def most_accurate_team(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.max_by {|team, acc| acc}[0]}.team_name
  end

  def least_accurate_team(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.min_by {|team, acc| acc}[0]}.team_name
  end

  def winningest_coach(season)
    team_performances = team_games_by_season(season)
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.max_by {|coach, wins| wins}[0]
  end

  def worst_coach(season)
    team_performances = team_games_by_season(season)
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.min_by {|coach, wins| wins}[0]
  end

  def most_tackles(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.max_by {|team, tack| tack}[0]}.team_name
  end

  def fewest_tackles(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.min_by {|team, tack| tack}[0]}.team_name
  end

  def team_info(team_id)
    # finds a specific team via their id
     team = team_by_id(team_id)
     # returns an array of the team object's instance variables, then iterates
     # over that array, deletes the '@' from the front of the instance variable
     # and assigns that as a key, then sets the value equal to the key by again
     # removing the '@' and then passing that as a method call then returning it
     # all as a hash
      team_data = team.instance_variables.map { |key,value| ["#{key}".delete("@"), value = team.send("#{key}".delete("@").to_sym)]}.to_h
      # searches the hash for a key, value pair whose key is "stadium" then deletes it.
      team_data.delete_if {|k,v| k == "stadium"}
  end

  def best_season(team_id)
    team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
    seasons = team_seasons.group_by {|game| game.season}
    seasons.each do |season, season_games|
      season_game_ids = season_games.map{|game| game.game_id}
      team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
      seasons[season] = calculate_win_percentage(team_games)
    end
    seasons.max_by { |season, win_pct|
      win_pct }[0]
  end

  def worst_season(team_id)
    team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
    seasons = team_seasons.group_by {|game| game.season}
    seasons.each do |season, season_games|
      season_game_ids = season_games.map{|game| game.game_id}
      team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
      seasons[season] = calculate_win_percentage(team_games)
    end
    seasons.min_by { |season, win_pct|
      win_pct }[0]
  end

  def average_win_percentage(team_id)
    # finds the number of games that a team both played in and won
    team_games = all_games_by_team(team_id)
    calculate_win_percentage(team_games).round(2)
    # returns the number of that team's wins over the total games they have played rounded to the 2nd decimal place
  end

  def all_games_by_team(team_id)
    @game_teams.find_all{|game_team| game_team.team_id == team_id}
  end

  def most_goals_scored(team_id)
    all_games_by_team(team_id).max_by{|game| game.goals}.goals
  end

  def fewest_goals_scored(team_id)
    all_games_by_team(team_id).min_by{|game| game.goals}.goals
  end

  def favorite_opponent(team_id)
    team_games = all_games_by_team(team_id)
    team_games.map! {|game| game.game_id}
    opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
    opp_teams = opp_team_games.group_by {|game| game.team_id}
    win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
    @teams.find {|team| team.team_id == win_pct_against.max_by {|team, win_pct| win_pct}[0]}.team_name
  end

  def rival(team_id)
    team_games = all_games_by_team(team_id)
    team_games.map! {|game| game.game_id}
    opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
    opp_teams = opp_team_games.group_by {|game| game.team_id}
    win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
    @teams.find {|team| team.team_id == win_pct_against.min_by {|team, win_pct| win_pct}[0]}.team_name
  end

  def calculate_win_percentage(team_games)
    wins = 0.0
    team_games.each {|game| wins += 1.0 if game.result == "WIN"}
    (wins / team_games.length)
  end

end
