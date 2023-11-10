require 'spec_helper'

RSpec.describe GameList do
  it "can create a new Game List class instance" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(game_list).to be_a(GameList)
    expect(game_list.games).to be_a(Array)
    expect(game_list.games[0]).to be_a(Game)
  end

  it "can create games" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    game_list.create_games('./data/games_subset.csv')

    expect(game_list.games.count).to eq(20)
  end

  xit "can calculate percentage of home wins" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(game_list.percentage_home_wins).to eq(0.70)
  end

  xit "can calculate percentage of visitor wins" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(game_list.percentage_visitor_wins).to eq(0.25)
  end

  xit "can calculate percentage of ties" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(game_list.percentage_ties).to eq(0.05)
  end

end