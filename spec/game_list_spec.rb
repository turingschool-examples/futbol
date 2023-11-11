require 'spec_helper'

RSpec.describe GameList do
  before(:each) do
    locations = {
      games: "./data/games_subset.csv",
      teams: "./data/teams_subset.csv",
      game_teams: "./data/game_teams_subset.csv"
    }
    stat_tracker = StatTracker.from_csv(locations)
    #passing in the instance not the class of stat tracker.
    @game_list = GameList.new(locations[:games], stat_tracker)
  end

  it "can create a new Game List class instance" do
    expect(@game_list).to be_a(GameList)
    expect(@game_list.games).to be_a(Array)
    expect(@game_list.games[0]).to be_a(Game)
  end

  it "can create games" do
    @game_list.create_games("./data/games_subset.csv")
    
    expect(@game_list.games).to all(be_an_instance_of Game)
  end

  it 'can find highest score' do
    expect(@game_list.highest_total_score).to eq(5)
  end

  it 'can find the lowest score' do
    expect(@game_list.lowest_total_score).to eq(1)
  end

  xit "can calculate percentage of home wins" do
    expect(@game_list.percentage_home_wins).to eq(0.70)
  end

  xit "can calculate percentage of visitor wins" do
    expect(@game_list.percentage_visitor_wins).to eq(0.25)
  end

  xit "can calculate percentage of ties" do
    expect(@game_list.percentage_ties).to eq(0.05)
  end
end