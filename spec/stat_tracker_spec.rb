require 'rspec'
require 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  xdescribe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  xdescribe '#game stats' do
    it 'can calculate the highest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'can calculate the lowest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it 'can calculate the percentage of games that a home team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'can calculate the percentage of games that an visitor team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it 'can calculate percentage of games that has resulted in a tie (rounded to the nearest 100th)' do 
      expect(@stat_tracker.percentage_ties).to eq(0.2)
    end
  end

  
















































 






























































































































































  xdescribe 'it handles the Season methods' do
    it "#winningest_coach" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end

    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

  describe 'Team statistics-best & worse season methods'do
    it "#best_season" do
      expect(@stat_tracker.best_season("6")).to eq "20132014"
    end

    it "#worst_season" do
      expect(@stat_tracker.worst_season("6")).to eq "20142015"
    end
  end
end