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

  it "can give the game with the highest total scores " do

    expect(@stat_tracker.highest_total_scores).to eq(5)
  end

  it "can give the game with the lowest total scores " do
    expect(@stat_tracker.lowest_total_scores).to eq(1)
  end

  it "can return percentage of home wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(68.42)
  end

  it "can return percentage of visitor wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(25.00)
  end

  it "can return the percentage of ties to game" do
    expect(@stat_tracker.percentage_ties).to eq(5.0)
  end

  it "can create a hash of amount of games per season" do
    expect(@stat_tracker.count_of_games_by_season).to eq({
      "20122013" => 39,
      "20152016" => 1
    }
    )
  end

  it 'can give total games played' do
    expect(@stat_tracker.total_games).to eq(40)
  end

  it 'can give total games played' do
    expect(@stat_tracker.total_goals).to eq(155)
  end

  it 'can return average goals scored per game' do
    expect(@stat_tracker.average_goals_per_game).to eq(3.88)
  end

  # xit 'can return total goals in a given season' do
  #   expect(@stat_tracker.total_goals_per_season('20122013')).to eq(151)
  # end
  #
  # xit 'can return total games played in season' do
  #   expect(@stat_tracker.total_games_per_season('20122013')).to eq(39)
  # end

  it 'can return average goals scored in a season' do
    expect(@stat_tracker.average_goals_by_season).to eq({
      "20122013" => 3.87,
      "20152016" => 4
      })
  end
end
