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

    #All tests in this spec file are for game_id 2012030221 (the first one on the games_dummy)
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

  it 'can tell whether a team participated' do
    expect(@game.team_in_game?(3)).to be true
    expect(@game.team_in_game?(6)).to be true
    expect(@game.team_in_game?(5)).to be false
  end

  it 'can return a hash of only one teams game stats' do
    expected = {
      :face_off_win_percentage=>44.8, 
      :goals=>2, :head_coach=>"John Tortorella", 
      :result=>"LOSS", 
      :shots=>8, 
      :tackles=>44, 
      :team_id=>3, 
      :team_name=>"Houston Dynamo"
    }
    expect(@game.team_stats(3)).to eq(expected)
  end


end
