require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/game_statistics'
require 'pry'

RSpec.describe GameStatistics do
  files = {game_stats: './data/dummy_game_teams.csv',
          games: './data/dummy_games.csv',
          teams: './data/dummy_teams.csv'}
  subject {GameStatistics.new(files)}

  it "exists" do
    expect(subject).to be_a GameStatistics
  end

  it "displays #highest total score of a game" do
    expect(subject.highest_total_score).to eq(6)
  end

  it "displays #lowest total score of a game" do
    expect(subject.lowest_total_score).to eq(1)
  end

  it "displays #percentage_home_wins" do
    expect(subject.percentage_home_wins).to eq(0.35)
  end

  it "displays #percentage_visitor_wins" do
    expect(subject.percentage_visitor_wins).to eq(0.13)
  end

  it "displays #percentage_ties" do
    expect(subject.percentage_ties).to eq(0.04)
  end

  it "displays #count_of_games_by_season" do
    expect(subject.count_of_games_by_season).to eq({"20122013"=>57, "20132014"=>10, "20142015"=>10})
  end

  it "displays #average_goals_per_game" do
    expect(subject.average_goals_per_game).to eq(3.91)
  end
end
