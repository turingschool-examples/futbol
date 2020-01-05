require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    # csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    #
    # csv.map { |row| GameTeams.new(row) }
    load_from_csv(file_path, GameTeams)
  end
end
