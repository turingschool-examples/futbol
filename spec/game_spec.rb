require 'spec_helper'

RSpec.describe Game do
  before(:all) do
    @games = Game.create_from_csv("./data/games.csv")
  end

  before(:each) do
    game_data = {
      game_id: 2012030221,
      season: 20122013,
      type: "Postseason",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3
    }
    @game1 = Game.new(game_data)
  end

  it 'exists' do
    expect(@game1).to be_an_instance_of Game
  end

  it 'has attributes that can be read' do
    expect(@game1.game_id).to eq 2012030221
    expect(@game1.season).to eq 20122013
    expect(@game1.type).to eq "Postseason"
    expect(@game1.away_team_id).to eq 3
    expect(@game1.home_team_id).to eq 6
    expect(@game1.away_goals).to eq 2
    expect(@game1.home_goals).to eq 3
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

  it "gets the highest total score from all games" do
    expect(@games.highest_total_score).to eq(11)
  end

  it "gets the lowest total score from all games" do
    expect(@games.lowest_total_score).to eq(0)
  end

end
