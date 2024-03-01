require 'spec_helper'

RSpec.describe Game do

  before(:all) do
    game_data = './data/games_dummy.csv'
    @games_test = Game.create_from_csv(game_data)
  end

  it 'exists' do
    expect(@games_test).to be_an_instance_of Game
  end
      
  it 'has attributes that can be read' do
    expect(@games_test.first.game_id).to eq 2012030221
    expect(@games_test.first.season).to eq 20122013
    expect(@games_test.first.type).to eq "Postseason"
    expect(@games_test.first.away_team_id).to eq 3
    expect(@games_test.first.home_team_id).to eq 6
    expect(@games_test.first.away_goals).to eq 2
    expect(@games_test.first.home_goals).to eq 3
  end

  it "can create Game objects using the create_from_csv method" do
    new_game = Game.create_from_csv("./data/games_dummy.csv")
    starter = new_game.first
    expect(starter.game_id).to eq 2012030221
    expect(starter.season).to eq 20122013
    expect(starter.type).to eq "Postseason"
    expect(starter.away_team_id).to eq 3
    expect(starter.home_team_id).to eq 6
    expect(starter.away_goals).to eq 2
    expect(starter.home_goals).to eq 3
  end

  it 'averages the goals per game' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.32)
  end
end