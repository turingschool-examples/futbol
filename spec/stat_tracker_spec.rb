require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/stat_tracker'
require 'CSV'
require 'spec_helper'

RSpec.describe StatTracker do
    before(:each) do
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
    
    describe '#initialize' do
        it 'exits' do
            expect(@stat_tracker).to be_instance_of(StatTracker)
        end
    end

    describe "#highest_total_score" do
        it 'can provide the highest combined score' do
            expect(@stat_tracker.highest_total_score).to eq(7)
            #expect(@stat_tracker.highest_total_score).to eq(11)
        end
    end

    describe "#lowest_total_score" do
    it 'can provide the lowest combined score' do
        expect(@stat_tracker.lowest_total_score).to eq(1)
        #expect(@stat_tracker.lowest_total_score).to eq(0)
    end
end

end