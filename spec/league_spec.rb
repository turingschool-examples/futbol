require './lib/league_tracker'


RSpec.describe do LeagueTracker
  it 'exists' do
    tracker = LeagueTracker.new
    expect(tracker).to be_a(LeagueTracker)
  end

  it 'can count teams' do
    tracker = LeagueTracker.new
    expect(tracker.count_of_teams).to eq(32)
  end

  xit 'can tell best offense' do
    game_path = './data/game_teams_stub.csv'
    locations = {games: game_path}
    league = League.new(locations[:games])
  end

  # it '' do
  # end
  #
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end

end
