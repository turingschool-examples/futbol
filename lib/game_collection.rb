require 'csv'

class GameCollection
  attr_accessor :games
  attr_reader :games_file_path

  def initialize
    @games = nil
    @games_file_path = './data/games.csv'
  end

  def from_csv
    @games = CSV.read(@games_file_path, headers: true, header_converters: :symbol)
  end
end
