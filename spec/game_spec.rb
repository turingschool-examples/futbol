require "./lib/game"
require "rspec"
require "csv"

describe Game do
  before do
    game_file = "./data/games_sampl.csv"
    game_lines = CSV.open game_file, headers: true, header_converters: :symbol
    games = []
    game_lines.each do |line|
      games << Game.new(line)
    end
    @game_1 = games[0]
    @game_2 = games[2] 
    @game_3 = games[11] 
    @game_4 = games[5] 
    @game_5 = games[12]
    @game_6 = games[9]
  end

  it "exists" do
    expect(@game_1).to be_a(Game)
  end

  it "has a game_id" do
    expect(@game_1.game_id).to eq("2012030221")
    expect(@game_2.game_id).to eq("2012030223")
  end

  it "has a season" do
    expect(@game_1.season).to eq("20122013")
    expect(@game_2.season).to eq("20122013")
    expect(@game_6.season).to eq("20132014")
  end

  it "has a season type" do
    expect(@game_1.season_type).to eq("Postseason")
    expect(@game_3.season_type).to eq("Regular Season")
  end

  it "has team ids" do
    expect(@game_1.away_team_id).to eq("3")
    expect(@game_1.home_team_id).to eq("6")
    expect(@game_2.away_team_id).to eq("6")
    expect(@game_2.home_team_id).to eq("3")
    expect(@game_3.away_team_id).to eq("29")
    expect(@game_3.home_team_id).to eq("24")
  end

  it "has goals" do
    expect(@game_1.away_goals).to eq(2)
    expect(@game_1.home_goals).to eq(3)
    expect(@game_3.away_goals).to eq(2)
    expect(@game_3.home_goals).to eq(3)
    expect(@game_5.away_goals).to eq(3)
    expect(@game_5.home_goals).to eq(3)
  end

  it "has a total goals scored" do
    expect(@game_1.total_goals).to eq(5)
    expect(@game_2.total_goals).to eq(3)
    expect(@game_3.total_goals).to eq(5)
    expect(@game_4.total_goals).to eq(3)
    expect(@game_5.total_goals).to eq(6)
  end

  it "has a winner" do
    expect(@game_1.winner).to eq("home")
    expect(@game_2.winner).to eq("away")
    expect(@game_3.winner).to eq("home")
    expect(@game_4.winner).to eq("away")
    expect(@game_5.winner).to eq("tie")
  end
end