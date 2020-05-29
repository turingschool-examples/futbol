require "csv"
require_relative "./game_team"
class GameTeamCollection
  def initialize(csv_loc)
    @game_path = csv_loc
  end

  def all
    data = CSV.read(@game_path, headers: true, header_converters: :symbol)
    data.map do |row|
      GameTeam.new(row)
    end
  end
end
