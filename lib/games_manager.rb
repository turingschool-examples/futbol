require 'csv'
require_relative './stat_tracker'
require_relative './game'
require_relative './manageable'

class GamesManager
  include Manageable

  attr_reader :stat_tracker, :games

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @games = []
    create_games(path)
  end

  def create_games(games_table)
    @games = games_table.map do |data|
      Game.new(data)
    end
  end

  def lowest_total_score
    @games.min_by do |game|
      game.total_game_score
    end.total_game_score
  end

  def highest_total_score
    @games.max_by do |game|
      game.total_game_score
    end.total_game_score
  end

  def percentage_ties
    ties = @games.count do |game|
      !game.home_is_winner? && !game.visitor_is_winner?
    end
    ratio(ties, total_games)
  end

  def percentage_home_wins
    wins = @games.count do |game|
      game.home_is_winner?
    end
    ratio(wins, total_games)
  end

  def percentage_visitor_wins
    wins = @games.count do |game|
      game.visitor_is_winner?
    end
    ratio(wins, total_games)
  end

  def total_games(games = @games)
    games.count
  end

  def total_goals(games = @games)
    games.sum do |game|
      (game.home_goals + game.away_goals)
    end
  end

  def average_goals_per_game
    ratio(total_goals, total_games)
  end

  def average_goals_by_season
    avg_goals_by_season = {}
    seasonal_game_data.each do |season, details|
      avg_goals_by_season[season] = ratio(total_goals(details), total_games(details))
    end
    avg_goals_by_season
  end

  def seasonal_game_data
    @games.group_by do |game|
      game.season
    end
  end

  def season_group
    @games.group_by do |row|
      row.season
    end
  end

  def game_ids_by_season(season)
    season_group[season].map do |game|
      game.game_id
    end.sort
  end

  def count_of_games_by_season
    count = {}
    season_group.each do |season, games|
      count[season] = games.count
    end
    count
  end

  def team_wins_as_home(team_id, season)
    season_group[season].find_all do |game|
      (game.home_team_id == team_id) && (game.home_is_winner?)
    end.count
  end

  def team_wins_as_away(team_id, season)
    season_group[season].find_all do |game|
      (game.away_team_id == team_id) && (game.visitor_is_winner?)
    end.count
  end

  def total_team_wins(team_id, season)
    team_wins_as_home(team_id, season) + team_wins_as_away(team_id, season)
  end

  def total_team_games_per_season(team_id, season)
    season_group[season].find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end.count
  end

  def season_win_percentage(team_id, season)
    find_percent(total_team_wins(team_id, season), total_team_games_per_season(team_id, season))
  end

  def all_seasons
    season_group.keys.sort
  end

  def all_teams_all_seasons_win_percentages
    @stat_tracker.fetch_all_team_ids.reduce({}) do |data, team_id|
      data[team_id] = all_seasons.reduce({}) do |collector, season|
        collector[season] = season_win_percentage(team_id, season)
        collector
      end
      data
    end
  end

  def best_season(team_id)
    all_teams_all_seasons_win_percentages.flat_map do |team, seasons|
      if team == team_id
        seasons.max_by do |season|
          season.last
        end
      end
    end.compact.first
  end

  def worst_season(team_id)
    all_teams_all_seasons_win_percentages.flat_map do |team, seasons|
      if team == team_id
        seasons.min_by do |season|
          season.last
        end
      end
    end.compact.first
  end

  def get_game(gameid)
    @games.find do |game|
      game.game_id == gameid
    end
  end

  def get_opponent_id(game, teamid)
    game.away_team_id == teamid ? game.home_team_id : game.away_team_id
  end

end
