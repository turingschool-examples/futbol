require 'simplecov'
SimpleCov.start
# require './lib/stat_tracker'
require './lib/game'

describe Game do
  before :each do
    @game1 = Game.new("2012030162", "20122013", "Postseason", "5/3/13", 17,
      24, 3, 2, "Rio Tinto Stadium", "/api/v1/venues/null")
    @game2 = Game.new("2013021017", "20132014", "Regular Season", "3/16/14", 21,
      9, 3, 1, "Yankee Stadium", "/api/v1/venues/null")
    @game3 = Game.new("2017021170", "20172018", "Regular Season", "3/26/18", 15,
      3, 2, 2, "BBVA Stadium", "/api/v1/venues/null")
    @game4 = Game.new("2012020249", "20122013", "Regular Season", "2/23/13", 28,
      16, 1, 2, "Gillette Stadium", "/api/v1/venues/null")
  end

  it "exists" do
    expect(@game1).to be_a(Game)
  end

  it "has attributes" do
    expect(@game1.game_id).to eq("2012030162")
    expect(@game1.season).to eq("20122013")
    expect(@game1.type).to eq("Postseason")
    expect(@game1.date_time).to eq("5/3/13")
    expect(@game1.away_team_id).to eq(17)
    expect(@game1.home_team_id).to eq(24)
    expect(@game1.away_goals).to eq(3)
    expect(@game1.home_goals).to eq(2)
    expect(@game1.venue).to eq("Rio Tinto Stadium")
    expect(@game1.venue_link).to eq("/api/v1/venues/null")
  end
end
