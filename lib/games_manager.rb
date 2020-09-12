require 'csv'
require_relative './stat_tracker'
require_relative './game'
require './lib/manageable'

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

  def total_games
    @games.count
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

  # This should be refactored fo sho  (takes a long time to run)
  # Currently it cycles through all games just to return an arrray
  # of unique seasons
  # But, should be moved to GamesManger
  def all_seasons
    unique_seasons = []
    @games.each do |game|
      if !unique_seasons.include?(game.season)
        unique_seasons << game.season
      end
    end
    unique_seasons.sort
  end


end
