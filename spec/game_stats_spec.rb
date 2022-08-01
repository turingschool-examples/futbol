require './lib/game_stats'
require './lib/game'
require './lib/game_teams'
require './lib/teams'

describe GameStats do
  before :each do
    game_path = "./data/games.csv"
    @game_stats = GameStats.from_csv(game_path)
    @game_stats.extend(Helpable)
  end
  
  it 'exists' do
    expect(@game_stats).to be_a(GameStats)
  end

  it "can calculate the games highest total score" do
    expect(@game_stats.highest_total_score).to eq(11)
  end
end