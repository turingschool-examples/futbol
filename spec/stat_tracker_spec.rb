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

  it 'returns percentage_ties' do
    expect(stat_tracker.percentage_ties).to eq(0.00)
  end

  it 'returns count of games by season' do
    expect(stat_tracker.count_of_games_by_season).to eq({'20122013' => 7})
  end

  it 'returns average goals per game' do
    expect(stat_tracker.average_goals_per_game).to eq(4.29)
  end

  it 'returns total goals by season' do
    expect(stat_tracker.total_goals_by_season).to eq({'20122013' => 30})
  end

  it 'returns average goals by season' do
    expect(stat_tracker.average_goals_by_season).to eq({'20122013' => 4.29})
  end

  #league stats
end
