require_relative "team"
require_relative "csv_loadable"

class TeamCollection
  include CsvLoadable

  attr_reader :teams

  def initialize(file_path)
    @teams = create_teams(file_path)
  end

  def create_games(file_path)
    # csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    #
    # csv.map { |row| Game.new(row) }

    load_from_csv(file_path, Team)
  end
end
