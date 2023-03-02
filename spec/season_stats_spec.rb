require 'spec_helper'
require 'csv'

describe LeagueStats do
  let(:game_path) { './data/games.csv' }
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

  xit 'can find winningest coach' do
  end

  it 'can find most accurate team' do
  #  team1 = stat_tracker.season_stats.most_accurate_team("20132014")
   team2 = stat_tracker.season_stats.most_accurate_team("20142015")
  #  expect(team1).to eq "Real Salt Lake"
   expect(team2).to eq "Toronto FC"
  end

  it 'can find least accurate team' do
    # team1 = stat_tracker.season_stats.most_accurate_team("20132014")
    team2 = stat_tracker.season_stats.least_accurate_team("20142015")
    # expect(team1).to eq "New York City FC"
    expect(team2).to eq "Columbus Crew SC"
  end

  xit 'can find the highest scoring home team' do
    expect(stat_tracker.season_stats.highest_scoring_home_team).to eq('Sporting Kansas City')
  end

  xit 'can find highest scoring away team' do
    expect(stat_tracker.season_stats.highest_scoring_away_team).to eq('Sporting Kansas City')
  end

  xit 'can find winningest coach' do
    expect(stat_tracker.season_stats.winningest_coach).to eq('Bruce Boudreau')
  end
  
  xit 'can find worst coach' do
    expect(stat_tracker.season_stats.worst_coach).to eq('Dave Tippett')
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