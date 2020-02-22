require 'csv'
require_relative 'season_win'
require_relative 'season_stat'

class StatTracker
  attr_reader :games_file, :teams_file, :game_teams_file

  def initialize(games_file, teams_file, game_teams_file)
    @games_file = games_file
    @teams_file = teams_file
    @game_teams_file = game_teams_file
  end

  def self.from_csv(locations_params)
    games_file = locations_params[:games]
    teams_file = locations_params[:teams]
    game_teams_file = locations_params[:game_teams]

    StatTracker.new(games_file, teams_file, game_teams_file)
  end

  def team_info(team_id)
    season_win = SeasonWin.new(@teams_file, @game_teams_file)
    season_win.team_info(team_id)
  end

  def best_season(team_id)
    season_win = SeasonWin.new(@teams_file, @game_teams_file)
    season_win.best_season(team_id)
  end

  def worst_season(team_id)
    season_win = SeasonWin.new(@teams_file, @game_teams_file)
    season_win.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    season_win = SeasonWin.new(@teams_file, @game_teams_file)
    season_win.average_win_percentage(team_id)
  end

  def count_of_games_by_season
    season = SeasonStat.new(@games_file, @teams_file, @game_teams_file)
    season.count_of_games_by_season
  end
end
