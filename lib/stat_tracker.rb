require 'csv'
require_relative 'league_stats'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'team_stats'

class StatTracker
 include AttrReadable

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_csv = CSV.read(@game_path, headers: true, header_converters: :symbol)
    @team_csv = CSV.read(@team_path, headers: true, header_converters: :symbol)
    @game_teams_csv = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)

    @locations = {
      game_csv: @game_path,
      team_csv: @team_path,
      gameteam_csv: @game_teams_path
    }

    @league_stats = LeagueStats.from_csv_paths(@locations)
    @season_stats = SeasonStats.from_csv_paths(@locations)
    @team_stats = TeamStats.from_csv_paths(@locations)
    @game_stats = GameStats.from_csv_paths(@locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def list_team_ids
    @team_csv.map { |row| row[:team_id] }
  end

  def list_team_names_by_id(id)
    @team_csv.each { |row| return row[:teamname] if id.to_s == row[:team_id] }
  end
end
