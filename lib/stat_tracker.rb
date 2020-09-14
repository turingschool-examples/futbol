require "csv"
require_relative "./teams_manager"
require_relative "./games_manager"
require_relative "./game_teams_manager"

class StatTracker
  attr_reader :teams_manager, :games_manager, :game_teams_manager

  def initialize(locations)
    load_managers(locations)
  end

  def self.from_csv(locations = {games: './data/games_sample.csv', teams: './data/teams_sample.csv', game_teams: './data/game_teams_sample.csv'})
    StatTracker.new(locations)
  end

  def load_managers(locations)
    @teams_manager = TeamsManager.new(load_csv(locations[:teams]), self)
    @games_manager = GamesManager.new(load_csv(locations[:games]), self)
    @game_teams_manager = GameTeamsManager.new(load_csv(locations[:game_teams]), self)
  end

  def load_csv(path)
    CSV.read(path, headers: true, header_converters: :symbol)
  end

# ~~~ Helper Methods ~~~~

#~~~ Fetcher Methods ~~~~
  def fetch_all_team_ids
    @teams_manager.all_team_ids
  end

  def fetch_season_win_percentage(team_id, season)
    @games_manager.season_win_percentage(team_id, season)
  end

  def fetch_team_identifier(team_id)
    @teams_manager.team_identifier(team_id)
  end

  def fetch_game_ids_by_season(season)
    @games_manager.game_ids_by_season(season)
  end

  def total_games(filtered_games = @games_manager.games)
    @games_manager.total_games
  end

  # potential module, perhaps GameTeams
  def season_group
    @games.group_by do |row|
      row.season
    end
  end

  def total_goals(filtered_games = @games_manager.games)
    @games_manager.total_goals(filtered_games)
  end

  def seasonal_game_data
    @games_manager.seasonal_game_data
  end

  # Move to GameTeamsManager
  def total_scores_by_team
    base = Hash.new(0)
    @game_teams.each do |game|
      key = game.team_id
      base[key] += game.goals
    end
    base
  end

  # Move to GameTeamsManager
  # I don't think this method is doing what it is supposed to be doing
  def average_scores_by_team
    total_scores_by_team.merge(games_containing_team){|team_id, scores, games_played| (scores.to_f / games_played).round(2)}
  end

  # Move to GameTeamsManager
  def games_containing_team
    games_by_team = Hash.new(0)
    @game_teams.each do |game|
      games_by_team[game.team_id.to_s] += 1
    end
    games_by_team
  end

  # Move to GameTeamsManager
  # Doesn't have a test
  def total_game_teams(filtered_game_teams = @game_teams)
    filtered_game_teams.count
  end

  # Move to GameTeamsManager
  # Doesn't have a test
  def avg_score(filtered_game_teams = @game_teams)
    @game_teams_manager.avg_score(filtered_game_teams)
  end

  # Move to TeamManager
  # This method has duplicates (team_names_by_team_id, team_id_to_team_name)
  def team_id_to_team_name(id)
    @teams_manager.team_identifier(id)
  end

  # This could potentially be replaced by sum_game_goals or vise versa
  # Doesn't have test
  def total_score(filtered_game_teams = @game_teams)
    filtered_game_teams.reduce(0) do |sum, game_team|
      sum += game_team.goals
    end
  end

  # Move to GameTeamsManager
  # THIS METHOD PENDING DELETION
  # using instead: home_or_away_games
  def home_games
    @game_teams.select do |game|
      game.hoa == "home"
    end
  end

  # Move to GameTeamsManager
  # THIS METHOD PENDING DELETION
  # using instead: home_or_away_games
  def away_games
    @game_teams.select do |game_team|
      game_team.hoa == "away"
    end
  end

  #Move to GameTeamsManager
  #Need a vertical call up for Team_ID
  # home_games method used inside will be changed to: home_or_away_games
  def home_games_by_team
    home_games.group_by do |game_team|
      game_team.team_id
    end
  end

  #Move to GameTeamsManager
  #Need a vertical call up for Team_ID
  # away_games method used inside will be changed to: home_or_away_games
  def away_games_by_team
    away_games.group_by do |game_team|
      game_team.team_id
    end
  end

  # This looks like it combines home_games and away_games - keep this one?
  # Move to GameTeams Manager
  # Doesn't have a test
  def home_or_away_games(where = "home")
    @game_teams.select do |game|
      game.hoa == where
    end
  end

  # Move to GamesTeamsManager
  def hoa_games_by_team_id(hoa)
    home_or_away_games(hoa).group_by do |game_team|
      game_team.team_id
    end
  end

  # Move to GameTeamsManager
  def lowest_scoring_team_id(hoa)
    hoa_games_by_team_id(hoa).min_by do |team_id, details|
      avg_score(details)
    end[0]
  end

  # Move to GameTeamsManager
  def total_wins(game_teams_filtered = @game_teams)
    game_teams_filtered.count do |gameteam|
      gameteam.result == "WIN"
    end
  end

  def filter_by_teamid(id)
    @game_teams_manager.filter_by_teamid(id)
  end

  # Move to GameTeamsManager
  # Need to convert to common naming convention
  def favorite_opponent(teamid)
    team_id_to_team_name(fave_opponent_id(teamid))
  end

  # Move to GameTeamsManager


  # Move to GameTeamsManager
  def rival_id(teamid)
    avg_win_perc_by_opp(teamid).min_by do |opponent, win_perc|
      win_perc
    end[0]
  end

  def game_teams_by_opponent(teamid)
    @game_teams_manager.game_teams_by_opponent(teamid)
  end

  def get_game(gameid)
    @games_manager.get_game(gameid)
  end

  # Move to GameTeamsManager
  #Duplicate method to filter_by_teamid
  def games_by_team(team_id)
    @game_teams.select do |game|
      game.team_id == team_id
    end
  end

  def get_opponent_id(gameid, teamid)
    @games_manager.get_opponent_id(gameid, teamid)
  end

  def game_ids_per_season(season)
    @game_teams_manager.game_ids_per_season(season)
  end

  def find_game_teams(game_ids)
    @game_teams_manager.find_game_teams(game_ids)
  end

  def shots_per_team_id(season)
    @game_teams_manager.shots_per_team_id(season)
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
    @game_teams_manager.shots_per_goal_per_season(season)
  end

  # Move to GamesManager

  def game_ids_by_season(season)
    filter_by_season(season).map do |game|
      game.game_id
    end.sort
  end

  # Move to GameTeamsManager
  def team_tackles(season)
    team_season_tackles = {}
    games = @game_teams.find_all do |game|
      game_ids_by_season(season).include?(game.game_id)
    end
    games.each do |game|
      if team_season_tackles[game.team_id]
        team_season_tackles[game.team_id] += game.tackles
      else
        team_season_tackles[game.team_id] = game.tackles
      end
    end
    team_season_tackles
  end

  # Move to GameTeamsManager
  def team_goals_by_game(team_id)
    games_by_team(team_id).map do |game|
      game.goals
    end
  end

# ~~~ Game Methods ~~~
  def lowest_total_score
    @games_manager.lowest_total_score
  end

  def highest_total_score
    @games_manager.highest_total_score
  end

  def percentage_visitor_wins
    @games_manager.percentage_visitor_wins
  end

  def percentage_ties
   @games_manager.percentage_ties
  end

  def percentage_home_wins
    @games_manager.percentage_home_wins
  end

  def count_of_games_by_season
    @games_manager.count_of_games_by_season
  end

  def average_goals_by_season
    @games_manager.average_goals_by_season
  end

  def average_goals_per_game
    @games_manager.average_goals_per_game
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

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def highest_scoring_home_team
    @game_teams_manager.highest_scoring_home_team
  end

  def highest_scoring_visitor
    @game_teams_manager.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    team_id_to_team_name(lowest_scoring_team_id("away"))
  end

  def lowest_scoring_home_team
    team_id_to_team_name(lowest_scoring_team_id("home"))
  end

# ~~~ SEASON METHODS~~~

  def winningest_coach(season)
    @game_teams_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams_manager.worst_coach(season)
  end

  def most_tackles(season)
    @game_teams_manager.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_teams_manager.fewest_tackles(season)
  end

  def most_accurate_team(season)
    @game_teams_manager.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_teams_manager.least_accurate_team(season)
  end

# ~~~ TEAM METHODS~~~

  def best_season(team_id)
    @games_manager.best_season(team_id)
  end

  def average_win_percentage(teamid)
    @game_teams_manager.average_win_percentage(teamid)
  end

  def rival(teamid)
    team_id_to_team_name(rival_id(teamid))
  end

  def worst_season(team_id)
    @games_manager.worst_season(team_id)
  end

  def team_info(team_id)
    @teams_manager.team_info(team_id)
  end

  def most_goals_scored(team_id)
    team_goals_by_game(team_id).max
  end

  def fewest_goals_scored(team_id)
    team_goals_by_game(team_id).min
  end
end
