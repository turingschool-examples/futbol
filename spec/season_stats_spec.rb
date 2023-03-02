require 'spec_helper'
describe LeagueStats do
  let(:game_path) { './data/game_teams.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }
  let(:locations) do {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  let(:season_stats) { SeasonStats.new(locations) }

  it 'can import team data' do
    expect(stat_tracker.season_stats.game_teams[0].game_id).to eq(2012030221)
  end

  it 'can find winningest coach' do
    expect(stat_tracker.season_stats.winningest_coach).to eq('Bruce Boudreau')
  end
  
  it 'can find worst coach' do
    expect(stat_tracker.season_stats.worst_coach).to eq('Dave Tippett')
  end
end