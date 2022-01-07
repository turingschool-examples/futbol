require './spec/spec_helper'
require './lib/stat_tracker'
require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require 'csv'

RSpec.describe 'Season Stats' do
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

  it 'pulls games of a given season' do #helper method tests
    expect(@stat_tracker.season.games_in_season(20172018).class).to be Array
  end

  it 'total goals per season works' do
    expected = {
      "15"  => 9.0,
      "5"   => 10.0,
      "30"  => 7.0,
      "52"  => 12.0
    }
    expect(@stat_tracker.season.total_goals_per_season(20172018)).to eq expected
  end

  it 'total shots per season works' do
    expected = {
      "15"  => 25.0,
      "5"   => 25.0,
      "30"  => 30.0,
      "52"  => 41.0
    }
    expect(@stat_tracker.season.total_shots_per_season(20172018)).to eq expected
  end

  it 'most accurate team works ' do

    expect(@stat_tracker.season.most_accurate_team(20172018)).to eq("Sporting Kansas City")
  end





end
