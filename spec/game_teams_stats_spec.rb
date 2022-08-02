require './lib/game_teams_stats'
require './lib/game'
require './lib/game_teams'
require './lib/teams'

describe GameTeamsStats do
  before :each do
    game_teams_path = "./data/game_teams.csv"
    @game_teams_stats = GameTeamsStats.from_csv(game_teams_path)
    @game_teams_stats.extend(Helpable)
  end

  it 'exists' do
    expect(@game_teams_stats).to be_a(GameTeamsStats)
  end

  it "can tell the most goals a team has scored in a game across all seasons" do
    expect(@game_teams_stats.most_goals_scored("18")).to eq(7)
  end

  it "can tell the fewest goals a team has scored in a game across all seasons" do
    expect(@game_teams_stats.fewest_goals_scored("18")).to eq(0)
  end

  it "can calculate which team had the best offense" do
    expect(@game_teams_stats.best_offense.size).to eq 32
  end

  it "can calculate which team had the worst offense" do
    expect(@game_teams_stats.worst_offense.size).to eq 32
    expect(@game_teams_stats.worst_offense[0][0].to_i).to eq 3
  end

end
