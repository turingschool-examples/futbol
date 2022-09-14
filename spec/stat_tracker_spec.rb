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

    it "#percentage_home_wins" do
        expect(@stat_tracker.percentage_home_wins).to eq 0.44
      end

      it "#percentage_visitor_wins" do
        expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
      end

      it "#percentage_ties" do
        expect(@stat_tracker.percentage_ties).to eq 0.20
      end

end
