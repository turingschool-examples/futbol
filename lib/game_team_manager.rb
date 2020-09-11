require_relative 'game_teams'
require 'csv'

class GameTeamManager
  attr_reader :game_teams
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = generate_game_teams(locations[:game_teams])
  end

  def generate_game_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end

  def team_by_id(team_id)
    @stat_tracker.team_info(team_id).name
  end

  def game_teams_data_for_season(season_id)
    @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
  end

end
