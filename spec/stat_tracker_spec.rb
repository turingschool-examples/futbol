require './spec/spec_helper'
require './lib/stat_tracker'
require 'csv'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    # @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    stat_tracker = StatTracker.new(@locations)
    expect(stat_tracker).to be_instance_of StatTracker
  end

  it 'loads from csv' do
    stat_tracker = StatTracker.from_csv(@locations)
    # require "pry"; binding.pry
    expect(stat_tracker).to be_instance_of StatTracker
    expect(stat_tracker.games.class).to be CSV::Table
    expect(stat_tracker.teams.class).to be CSV::Table
    expect(stat_tracker.game_teams.class).to be CSV::Table
  end
end

RSpec.describe 'Game Stats' do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'reports highest total score' do
    expect(@stat_tracker.highest_total_score).to be 7
  end

  it 'reports lowest total score' do
    expect(@stat_tracker.lowest_total_score).to be 2
  end

  it 'reports average goals per game' do
    expect(@stat_tracker.average_goals_per_game).to be 4.39
  end

  it 'reports average goals per game by season' do
    expected = {
      '20122013' => 5.2,
      '20132014' => 4,
      '20152016' => 3,
      '20172018' => 4.22
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  it 'can find the percentage of games that ended in a tie' do
    expect(@stat_tracker.percentage_ties).to eq(16.667)
  end

  xit 'can sort games by season' do
    expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)
    expect(@stat_tracker.count_of_games_by_season).to include('20172018' => 9)
  end
end
