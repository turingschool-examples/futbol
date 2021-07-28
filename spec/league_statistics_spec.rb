require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do

  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@file_paths)
  end

  it 'total number of teams in the data' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it 'returns total goals all seasons per team' do
    expect(@stat_tracker.total_goals_all_seasons(3)).to eq(8)
  end

  it 'returns total games all seasons per team' do
    expect(@stat_tracker.total_games_all_seasons(3)).to eq(5)
  end

  it 'returns average goals for all seasons per team' do
    expect(@stat_tracker.average_goals_all_seasons(3)).to eq(1.60)
  end

  it 'team by id' do
    expect(@stat_tracker.team_by_id(3)).to eq("Houston Dynamo")
  end

  it 'returns team with highest average goals across seasons' do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it 'returns team with lowest average goals across seasons' do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end
end
