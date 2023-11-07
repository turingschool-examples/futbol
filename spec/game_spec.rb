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
    stat_tracker = StatTracker.new
    require 'pry'; binding.pry

  end

end