require 'spec_helper'

RSpec.describe Game do
  it "can create a new Game class instance" do
    game_1 = Game.new({game_id: "2012030221", season:"20122013", type:"Postseason", date_time:"5/16/13", away_team_id:"3", home_team_id:"6", away_goals:2, home_goals:3, venue:"Toyota Stadium", venue_link:"/api/v1/venues/null"}, GameList)

    expect(game_1).to be_a(Game)
    expect(game_1.game_id).to eq("2012030221")
    expect(game_1.season).to eq("20122013")
    expect(game_1.type).to eq("Postseason")
    expect(game_1.date_time).to eq("5/16/13")
    expect(game_1.away_team_id).to eq("3")
    expect(game_1.home_team_id).to eq("6")
    expect(game_1.away_goals).to eq(2)
    expect(game_1.home_goals).to eq(3)
    expect(game_1.venue).to eq("Toyota Stadium")
    expect(game_1.venue_link).to eq("/api/v1/venues/null")

    game_2 = Game.new({game_id:"2012030222", season:"20122013", type:"Postseason", date_time:"5/19/13", away_team_id:"3", home_team_id:"6", away_goals:2, home_goals:3, venue:"Toyota Stadium", venue_link:"/api/v1/venues/null"}, GameList)

    expect(game_2).to be_a(Game)
    expect(game_2.game_id).to eq("2012030222")
    expect(game_2.season).to eq("20122013")
    expect(game_2.type).to eq("Postseason")
    expect(game_2.date_time).to eq("5/19/13")
    expect(game_2.away_team_id).to eq("3")
    expect(game_2.home_team_id).to eq("6")
    expect(game_2.away_goals).to eq(2)
    expect(game_2.home_goals).to eq(3)
    expect(game_2.venue).to eq("Toyota Stadium")
    expect(game_2.venue_link).to eq("/api/v1/venues/null")
  end

end