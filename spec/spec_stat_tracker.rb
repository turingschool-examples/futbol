require './lib/stat_tracker'

RSpec.describe StatTracker do
  let(:locations) do {
    games: './data/dummy_games.csv',
    teams: './data/dummy_teams.csv',
    game_teams: './data/dummy_game_teams.csv'
  } end

  let(:stat_tracker) {StatTracker.from_csv(locations)}

  it 'StatTracker exists' do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'returns highest_total_score' do
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it 'returns lowest_total_score' do
    expect(stat_tracker.lowest_total_score).to eq(3)
  end

  it 'returns percentage_home_wins' do
    expect(stat_tracker.percentage_home_wins).to eq(42.86)
  end

  it 'returns percentage_visitor_wins' do
    expect(stat_tracker.percentage_visitor_wins).to eq(57.14)
  end
end
