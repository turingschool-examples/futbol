require './lib/game_teams_stats'
require './lib/game'
require './lib/game_teams'
require './lib/teams'

describe GameTeamsStats do
  before :each do
    game_teams_path = "./data/game_teams.csv"
    @game_teams_stats = GameTeamsStats.from_csv(game_teams_path)
  end
  
  it 'exists' do
    expect(@game_teams_stats).to be_a(GameTeamsStats)
  end

  xit "can calculate which team had the best offense" do
    expect(@game_teams_stats.best_offense).to eq "Reign FC"
  end






end