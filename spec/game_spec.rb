require 'spec_helper'

RSpec.describe Game do
  it "exists" do
    game_1 = Game.new("2012030221","20122013","Postseason","5/16/13","3","6",2,3)
    expect(game_1).to be_a Game
  end

  it "has instance variables" do
    game_1 = Game.new("2012030221","20122013","Postseason","5/16/13","3","6",2,3)
    expect(game_1.game_id).to eq("2012030221")
    expect(game_1.season).to eq("20122013")
    expect(game_1.game_type).to eq("Postseason")
    expect(game_1.game_date_time).to eq("5/16/13")
    expect(game_1.away_team_id).to eq("3")
    expect(game_1.home_team_id).to eq("6")
    expect(game_1.away_goals).to eq(2)
    expect(game_1.home_goals).to eq(3)
    Game.create_games
  end

  it "has a create games class method" do
    expect(Game.create_games).to be_an Array
    Game.create_games.each do |game|
      expect(game).to be_a Game
    end
  end
end
  # it "can return the highest amount of total goals in a game" do
  #   game_1 = Game.new("2012030221","20122013","Postseason","5/16/13","3","6",2,3)
  #   expect(game_1.highest_total_scores).to eq(5)
  # end

  # it "can return the lowest amount of total goals in a game" do
  #   game_1 = Game.new("2012030314","20122013","Postseason","6/8/13","5","6",0,1)
  #   expect(game_1.lowest_total_scores).to eq(1)
  # end
