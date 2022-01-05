require 'pry'
class Games
  attr_reader :games_file, :read_file
  def initialize(games_file)
    @games_file = games_file
    @read_games = []
    read_file
  end

  def read_file
    @read_games = CSV.read @games_file, headers: true, header_converters: :symbol
  end
end
