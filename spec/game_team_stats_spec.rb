require './lib/game_stats'
require './lib/game'
require './lib/game_teams'
require './lib/teams'

describe GameTeamStats do
  before :each do
    game_teams_path = "./data/game_teams.csv"
    @game_team_stats = GameStats.from_csv(game_path)
  end
  
  it 'exists' do
    expect(@game_team_stats).to be_a(GameTeamStats)
  end

  it "can calculate which team had the best offense" do
    expect(@game_team_stats.best_offense).to eq "Reign FC"
  end


  end



end