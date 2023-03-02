require 'spec_helper'
require 'csv'

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


    expect(stat_tracker.season_stats.winningest_coach('20132014')).to eq('Claude Julien')
    expect(stat_tracker.season_stats.winningest_coach('20142015')).to eq('Alain Vigneault')
  end
  
  it 'can find worst coach' do

    expect(stat_tracker.season_stats.worst_coach('20132014')).to eq('Peter Laviolette')
    expect(stat_tracker.season_stats.worst_coach('20142015')).to eq('Craig MacTavish').or(eq('Ted Nolan'))
  end

  it 'can find most accurate team' do

    expect(stat_tracker.season_stats.most_accurate_team('20132014')).to eq('Real Salt Lake')
    expect(stat_tracker.season_stats.most_accurate_team('20142015')).to eq('Toronto FC')
  end

  it 'can find least accurate team' do

    expect(stat_tracker.season_stats.least_accurate_team('20132014')).to eq('New York City FC')
    expect(stat_tracker.season_stats.least_accurate_team('20142015')).to eq('Columbus Crew SC')
  end

  it 'can list most tackles' do

    expect(stat_tracker.season_stats.most_tackles('20132014')).to eq('FC Cincinnati')
    expect(stat_tracker.season_stats.most_tackles('20142015')).to eq('Seattle Soudners FC')
  end

  it 'can list least tackles' do

    expect(stat_tracker.season_stats.least_tackles('20132014')).to eq('Atlanta United')
    expect(stat_tracker.season_stats.least_tackles('20142015')).to eq('Orlando City SC')
  end

  it 'can name team with most tackles' do
    stat_tracker.season_stats.total_team_tackles
    expect(stat_tracker.season_stats.most_team_tackles).to eq("FC Cincinnati")
  end

  it 'can name team with least tackles' do
    stat_tracker.season_stats.total_team_tackles
    expect(stat_tracker.season_stats.least_team_tackles).to eq("Reign FC")
  end
end