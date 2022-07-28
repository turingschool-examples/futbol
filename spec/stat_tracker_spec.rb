require './lib/stat_tracker'

RSpec.describe StatTracker do
  let(:locations) do {
    games: './data/dummy_games.csv',
    teams: './data/teams.csv',
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
    expect(stat_tracker.percentage_home_wins).to eq(0.43)
  end

  it 'returns percentage_visitor_wins' do
    expect(stat_tracker.percentage_visitor_wins).to eq(0.57)
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

  #season stats
  it 'returns winningestcoach' do
    expect(stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
  end

  it 'returns worst_coach' do
    expect(stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
  end

  it 'returns most_accurate_team' do
    expect(stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
  end

  it 'returns least_accurate_team' do
    expect(stat_tracker.least_accurate_team("20122013")).to eq("Houston Dynamo")
  end

  it 'returns most_tackles' do
    expect(stat_tracker.most_tackles("20122013")).to eq("Houston Dynamo")
  end

  it 'returns fewest_tackles' do
    expect(stat_tracker.fewest_tackles("20122013")).to eq("FC Dallas")
  end
end
