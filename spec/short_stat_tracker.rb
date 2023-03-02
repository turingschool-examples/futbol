require 'spec_helper'
require 'csv'

describe StatTracker do
  let(:game_path) { './data/short_games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/short_game_teams.csv' }
  let(:locations) do {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
end
let(:stat_tracker) { StatTracker.from_csv(locations) }

  it 'can import shortened game data' do
    expect(stat_tracker.game_stats.games).to be_instance_of(Array)
    expect(stat_tracker.game_stats.games.length).to eq(14)
  end
  it 'can import shortened game_team data' do
    expect(stat_tracker.league_stats.game_teams).to be_instance_of(Array)
    expect(stat_tracker.league_stats.game_teams.length).to eq(28)
  end
  it 'can import team data' do
    expect(stat_tracker.season_stats.teams).to be_instance_of(Array)
    expect(stat_tracker.season_stats.teams.length).to eq(32)
  end


end