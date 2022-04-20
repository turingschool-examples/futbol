require './required_files'


describe Game do
  before :each do
    @game1 = Game.new({game_id: "2012030162", season: "20122013", type: "Postseason", date_time: "5/3/13", away_team_id: 17,
      home_team_id: 24, away_goals: 3, home_goals: 2, venue: "Rio Tinto Stadium", venue_link: "/api/v1/venues/null"})
    @game2 = Game.new({game_id: "2013021017", season: "20132014", type: "Regular Season", date_time: "3/16/14", away_team_id: 21,
      home_team_id: 9, away_goals: 3, home_goals: 1, venue: "Yankee Stadium", venue_link: "/api/v1/venues/null"})
    @game3 = Game.new({game_id: "2017021170", season: "20172018", type: "Regular Season", date_time: "3/26/18", away_team_id: 15,
      home_team_id: 3, away_goals: 2, home_goals: 2, venue: "BBVA Stadium", venue_link: "/api/v1/venues/null"})
    @game4 = Game.new({game_id: "2012020249", season: "20122013", type: "Regular Season", date_time: "2/23/13", away_team_id: 28,
      home_team_id: 16, away_goals: 1, home_goals: 2, venue: "Gillette Stadium", venue_link: "/api/v1/venues/null"})
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
