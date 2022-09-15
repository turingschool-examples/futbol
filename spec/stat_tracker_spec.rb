require 'rspec'
require './lib/stat_tracker'
require 'csv'

RSpec.describe StatTracker do
    before(:each) do
        @game_path = './data/games.csv'
        @team_path = './data/teams.csv'
        @game_teams_path = './data/game_teams.csv'

        @locations = {
            games: @game_path,
            teams: @team_path,
            game_teams: @game_teams_path
        }

        @stat_tracker = StatTracker.from_csv(@locations)

    end

    it '1. exists' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it '2. knows CSV locations' do
        expect(@stat_tracker.game_path).to eq('./data/games.csv')
    end

    it '3. can read the CSV files' do
        expect(@stat_tracker.list_team_ids.length).to eq(32)
    end

    it '4. can return team name from id' do
        expect(@stat_tracker.list_team_names_by_id(13)).to eq("Houston Dash")
    end

    it '5. returns #highest_total_score' do
        expect(@stat_tracker.highest_total_score).to eq 11
      end
    
    it '6. #lowest_total_score' do
        expect(@stat_tracker.lowest_total_score).to eq 0
    end

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
