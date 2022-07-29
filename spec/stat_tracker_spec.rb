require './lib/stat_tracker'
require './lib/league_stats'

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

  xit '1. exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  xit '3. can load an array of multiple CSVs' do
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


  context 'Season statistics' do
    xit 'S1. has a method for winningest_coach' do
      expect(@stat_tracker.game_teams[:head_coach]).to include(@stat_tracker.winningest_coach("20122013"))
      expect(@stat_tracker.winningest_coach("20122013")). to be_a String
    end

    xit 'S2. has a method for worst_coach' do
      expect(@stat_tracker.game_teams[:head_coach]).to include(@stat_tracker.worst_coach("20122013"))
      expect(@stat_tracker.worst_coach("20122013")). to be_a String
    end

    xit 'S3. can tell most_accurate_team' do
      expect(@stat_tracker.teams[:teamname]).to include(@stat_tracker.most_accurate_team("20122013"))
      expect(@stat_tracker.most_accurate_team("20122013")). to be_a String
    end

    xit 'S3. can tell least_accurate_team' do
      expect(@stat_tracker.teams[:teamname]).to include(@stat_tracker.least_accurate_team("20122013"))
      expect(@stat_tracker.least_accurate_team("20122013")). to be_a String
    end

    xit 'can tell the team with the most tackles in a season' do
      expect(@stat_tracker.teams[:teamname]).to include(@stat_tracker.most_tackles("20122013"))
      expect(@stat_tracker.most_tackles("20122013")).to be_a String
    end

    xit 'can tell the team with the fewest tackles in a season' do
      expect(@stat_tracker.teams[:teamname]).to include(@stat_tracker.fewest_tackles("20122013"))
      expect(@stat_tracker.fewest_tackles("20122013")).to be_a String
    end
  end
end
