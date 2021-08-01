require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_statistics'
require_relative './season_statistics'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    teams = []
    game_teams = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      games << Game.new(row)
    end

    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      teams << Team.new(row)
    end

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      game_teams << GameTeams.new(row)
    end

    StatTracker.new(games, teams, game_teams)
  end

  def game_statistics
    GameStatistics.new(@games, @teams, @game_teams)
  end

  def season_statistics
    SeasonStatistics.new(@games, @teams, @game_teams)
  end

  def highest_total_score
    game_statistics.highest_total_score
  end

  def lowest_total_score
    game_statistics.lowest_total_score
  end

  def percentage_home_wins
    game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    game_statistics.percentage_ties
  end

  def home_team_wins
    game_statistics.home_team_wins
  end

  def visitor_team_wins
    game_statistics.visitor_team_wins
  end

  def ties
    game_statistics.ties
  end

  def count_of_games_by_season
    game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    game_statistics.average_goals_per_game
  end

  def total_goals_by_season
    game_statistics.total_goals_by_season
  end

  def average_goals_by_season
    game_statistics.average_goals_by_season
  end

  def most_accurate_team(season)
    season_statistics.most_accurate_team(season)
  end

  def least_accurate_team(season)
    season_statistics.least_accurate_team(season)
  end

  def winningest_coach(season)
    season_statistics.winningest_coach(season)
  end

  def worst_coach(season)
    season_statistics.worst_coach(season)
  end

  def most_tackles(season)
    season_statistics.most_tackles(season)
  end

  def fewest_tackles(season)
    season_statistics.fewest_tackles(season)
  end

# League stats start
  def count_of_teams
    @teams.length
  end

  def worst_offense
    acc = {}
    @teams.each do |team|
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.min]
  end

  def best_offense
    acc = {}
    @teams.each do |team|
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.max]
  end

  def games_average(team_id)
    goals_scored = 0.00
    games_by_team(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored / games_by_team(team_id).length
  end

  def games_by_team(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id.to_s
    end
  end

  def away_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'away'
    end
  end

  def away_average(team_id)
    goals_scored = 0.00
    away_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(away_games(team_id).length)
  end

  def highest_scoring_visitor
    highest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        highest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_visitor
    lowest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end

  def home_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'home'
    end
  end

  def home_average(team_id)
    goals_scored = 0.00
    home_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(home_games(team_id).length)
  end

  def highest_scoring_home_team
    highest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        highest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_home_team
    lowest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end
# Team stats start
  def team_info(team_id)
    team_info = {}
    @teams.each do |team|
      if team.team_id == team_id
        team_info["team_id"] = team.team_id
        team_info["franchise_id"] = team.franchise_id
        team_info["team_name"] = team.team_name
        team_info["abbreviation"] = team.abbreviation
        team_info["link"] = team.link
      end
    end
    team_info
  end

  def games_won(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id && game.result == "WIN"
    end
  end

  def all_games_played(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def average_win_percentage(team_id)
    games_won(team_id).length.fdiv(all_games_played(team_id).length).round(2)
  end

  def most_goals_scored(team_id)
    all_games_played(team_id).max_by do |game|
      game.goals
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    all_games_played(team_id).min_by do |game|
      game.goals
    end.goals.to_i
  end

  def all_seasons
    seasons = []
    @games.each do |game|
      seasons << game.season if !seasons.include?(game.season)
    end
    seasons
  end

  def best_season(team_id)
    all_seasons.max_by do |season|
       [season_win_percentage(season, team_id)].compact
    end
  end

  def season_win_percentage(season, team_id)
    winning_game_ids = games_won(team_id).map do |game|
      game.game_id
    end

    games_in_season = []
    total_games = 0
    @games.each do |game|
      if game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id)
        total_games += 1
      end
      if game.season == season
        games_in_season << game.game_id
      end
    end

    winning_game_in_season_ids = winning_game_ids & games_in_season
    if total_games != 0
      winning_game_in_season_ids.length.fdiv(total_games)
    end
  end

  def worst_season(team_id)
    all_seasons.min_by do |season|
       [season_win_percentage(season, team_id)].compact
    end
  end

  def all_opponents(team_id)
    @games.filter_map do |game|
      if team_id == game.home_team_id
        game.away_team_id
      elsif team_id == game.away_team_id
        game.home_team_id
      end
    end.uniq
  end

  def team_opponent_win_percentage(opponent_id, team_id)
    team_wins = 0
    total_games = 0
    @games.each do |game|
      #lots of functionality may be moved to games_class
      if game.away_team_id == team_id && game.home_team_id == opponent_id
        team_wins +=1 if game.away_goals > game.home_goals
        total_games += 1
      elsif game.home_team_id == team_id && game.away_team_id == opponent_id
        team_wins += 1 if game.away_goals < game.home_goals
        total_games += 1
      end
    end
    team_wins.fdiv(total_games)
  end

  def favorite_opponent(team_id)
    favorite_opponent_name = nil
    favorite_opponent_id = all_opponents(team_id).max_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end
    @teams.each do |team|
      if team.team_id == favorite_opponent_id
        favorite_opponent_name = team.team_name
      end
    end
    favorite_opponent_name
  end

  def rival(team_id)
    rival = nil
    rival_id = all_opponents(team_id).min_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end
    @teams.each do |team|
      if team.team_id == rival_id
        rival = team.team_name
      end
    end
    rival
  end
end
