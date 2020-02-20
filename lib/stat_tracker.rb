require 'csv'
require_relative 'season_win'
require_relative 'season'

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
    SeasonWin.new(team_id)
  end

  def count_of_games_by_season
    season = Season.new(season)
  end
end
