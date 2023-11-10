require 'spec_helper'

RSpec.describe GameList do
  it "can create a new Game List class instance" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(game_list).to be_a(GameList)
    expect(game_list.games).to eq([])
  end

  it "can create games" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    game_list.create_games('./data/games_subset.csv')

    expect(game_list.games.count).to eq(20)
  end

  # no tests are passing - incorrect arguments for Game.new (received 2, expected 10)

end