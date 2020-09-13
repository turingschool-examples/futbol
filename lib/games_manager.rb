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

  def all_seasons
    season_group.keys.sort
  end

  # Also needs refactored - maybe don't need to return hash?
  # Or use reduce?
  # Move to GamesManager
  def all_teams_all_seasons_win_percentages
    win_percentages_by_season = {}
    all_seasons.each do |season|
      @stat_tracker.fetch_all_team_ids.each do |team_id|
        if win_percentages_by_season[team_id] == nil
          win_percentages_by_season[team_id] = {season =>
            season_win_percentage(team_id, season)}
        else
          win_percentages_by_season[team_id][season] =
          season_win_percentage(team_id, season)
        end
      end
    end
    win_percentages_by_season
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


end
