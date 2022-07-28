require './lib/stat_tracker'

RSpec.describe Game do
  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    #All tests in thie spec file are for game_id 2012030221 (the first one on the games_dummy)
    @game = stat_tracker.games[0]
  end

  it 'exists' do
   expect(@game).to be_an(Game)
   expect(@game.game_id).to eq(2012030221)
 end

  it 'can return total number of goals' do
    expect(@game.total_goals).to eq(5)
  end

  it 'can return a winner symbol' do
    expect(@game.winner).to eq(:home_team)
  end
end
