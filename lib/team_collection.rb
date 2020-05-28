require "csv"
require_relative "./team"
class TeamCollection
  def initialize(csv_loc)
    @game_path = csv_loc
  end

  def all
    data = CSV.read(@game_path, headers: true, header_converters: :symbol)
    data.map do |row|
      Team.new(row)
    end
  end
end
