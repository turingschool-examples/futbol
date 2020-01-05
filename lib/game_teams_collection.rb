require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end

  def games_by_team_id(team_id)
    @game_teams_array.select {|game_team| game_team.team_id.to_i == team_id}
  end
end
