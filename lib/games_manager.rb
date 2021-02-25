require './lib/game'

class GamesManager
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Game.new(row)
    end
    list_of_data
  end


end
