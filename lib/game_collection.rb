require_relative "./helper"

class GameCollection
  def initialize(csv_loc)
    @game_path = csv_loc
  end

  def all
    data = CSV.read(@game_path, headers: true, header_converters: :symbol)
    data.map do |row|
      Game.new(row)
    end
  end
end
