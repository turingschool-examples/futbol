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
  
  let(:league_stats) { LeagueStats.new(locations) }

  it 'can import team data' do
    expect(stat_tracker.league_stats.teams[0].team_id).to eq("1")
  end

  it 'can return a count of teams' do
    expect(stat_tracker.league_stats.count_of_teams).to eq(32)
  end

  it 'can store team total goals' do

    expect(stat_tracker.league_stats.lowest_scoring_home).to eq("Reign FC")
    expect(stat_tracker.league_stats.lowest_scoring_away).to eq("Reign FC")
  end

  it 'can return team with best offense' do
    expect(stat_tracker.league_stats.best_offense).to eq("Reign FC")
  end

  it 'can return team with worst offense' do
    expect(stat_tracker.league_stats.worst_offense).to eq("Utah Royals FC")
  end

  it 'can find the highest scoring home team' do
    expect(stat_tracker.league_stats.highest_scoring_home_team).to eq('Sporting Kansas City')
  end

  it 'can find highest scoring away team' do
    expect(stat_tracker.league_stats.highest_scoring_away_team).to eq('Sporting Kansas City')
  end
end