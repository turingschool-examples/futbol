require './lib/stat_tracker'
require 'pry'

RSpec.describe StatTracker do

  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '1. exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '3. can load an array of multiple CSVs' do
    expect(@stat_tracker.games).to be_a(CSV::Table)
    expect(@stat_tracker.teams).to be_a(CSV::Table)
    expect(@stat_tracker.game_teams).to be_a(CSV::Table)
  end

  describe 'League Methods' do

    it 'can count teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end

    it 'can find best offense' do
      expect(@stat_tracker.best_offense).to eq "FC Dallas"
    end

    it 'can find worst offense' do
      expect(@stat_tracker.worst_offense).to eq "Sky Blue FC"
    end

    it 'can find highest scoring visitor' do
      expect(@stat_tracker.highest_scoring_visitor).to eq "Columbus Crew SC"
    end

    it 'can find highest scoring home team' do    
      expect(@stat_tracker.highest_scoring_home_team).to eq "San Jose Earthquakes"
    end

    it 'can find lowest scoring visitor' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "Chicago Fire"
    end

    it 'can find lowest scoring home team' do 
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Washington Spirit FC"
    end
  end
end
