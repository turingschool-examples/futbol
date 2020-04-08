require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games_list, :pct_data

  def initialize(file_path)
    @games_list = create_games(file_path)
    @pct_data = Hash.new { |hash, key| hash[key] = 0 }
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end


end
