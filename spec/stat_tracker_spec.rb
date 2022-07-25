require './lib/stat_tracker.rb'


  describe StatTracker do
  before :each do
    @stat_tracker = StatTracker.new
  end

  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it 'has the right class' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
  end





end