require 'pry'
class Games
  attr_reader :games_file, :readfile
  def initialize(games_file)
    @games_file = games_file
  end

  def readfile
    read_games = CSV.read @games_file, headers: true, header_converters: :symbol
    binding.pry
  end
end
