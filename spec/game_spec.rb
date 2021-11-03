require 'csv'
require './lib/game.rb'

RSpec.describe Game do

before(:each) do
  @game_path       = './data/games_sample.csv'

end


  def to_array
    rows = []

    CSV.foreach(@game_path, headers: true, header_converters: :symbol) do |row|
      rows << row.to_h
    end
    game_board = rows.map do |row|
      Game.new(row)
      require "pry"; binding.pry
    end
  end

  it 'exists' do
    game = Game.new(@game_path)
    game.to_array
    expect()
  end
end
