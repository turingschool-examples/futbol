require "./lib/game"
require "rspec"
require "csv"

describe Game do
  before do
    @game_file = "./data/games_sampl.csv"
    @game_lines = CSV.open @game_file, headers: true, header_converters: :symbol
    @games = []
    @game_lines.each do |line|
      @games << Game.new(line)
    end
    @game_1 = @games[0] #2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
    @game_2 = @games[2] #2012030222,20122013,Postseason,5/19/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
    @game_3 = @games[11] #2012020225,20122013,Regular Season,2/19/13,29,24,2,3,Rio Tinto Stadium,/api/v1/venues/null
    @game_4 = @games[5] 
  end

  it "exists" do
    expect(@game_1).to be_a(Game)
  end

  it "has game_id, season, season_type, away_team_id, home_team_id, away_goals, home_goals" do
    expect(@game_1.game_id).to eq("2012030221")
    expect(@game_1.season).to eq("20122013")
    expect(@game_1.season_type).to eq("Postseason")
    expect(@game_3.season_type).to eq("Regular Season")
    expect(@game_1.away_team_id).to eq("3")
    expect(@game_1.home_team_id).to eq("6")
    expect(@game_1.away_goals).to eq(2)
    expect(@game_1.home_goals).to eq(3)
  end

  it 'has a total goals scored' do
    expect(@game_1.total_goals).to eq(5)
    expect(@game_2.total_goals).to eq(5)
    expect(@game_3.total_goals).to eq(5)
    expect(@game_4.total_goals).to eq(3)
  end
end