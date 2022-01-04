require './lib/stat_tracker'
require 'pry'
# require_relative 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    stat_tracker = StatTracker.new("places")
    # binding.pry
    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'from CSV create new StatTracker' do

    stat_tracker = StatTracker.from_csv(@locations)
    expect(stat_tracker).to be_a(StatTracker)
    expect(stat_tracker.locations).to eq(@locations)
  end

  it "returns highest total score" do
    # stat_tracker = StatTracker.from_csv(@locations)
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  xit "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  xit "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  xit "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  xit "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.20
  end

  xit "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_of_games_by_season).to eq expected
  end

  xit "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end
end
