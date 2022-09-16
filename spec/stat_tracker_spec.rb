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

    it '13. returns count_of_teams'do
       expect(@stat_tracker.count_of_teams).to eq 32

    end

    it '14. #best_offense returns the team with the best_offense' do
       expect(@stat_tracker.best_offense).to eq "Reign FC"
    end

    it '15. #worst_offense returns the team with the worst_offense' do
       expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end

    it '16. #highest_scoring_visitor returns the highest scoring visitor' do
       expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    it '17. returns the highest_scoring_home_team' do
       expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end

    it '18. returns the lowest_scoring_visitor' do
       expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end

    it '19. returns the lowest_scoring_home_team' do
       expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
      
    end
end
