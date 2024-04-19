require 'spec_helper.rb'

RSpec.describe GameStats do
  before(:each) do
    @game_path = './data/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_fixture.csv'
    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    end

    describe "#count_of_games_by_season" do
        it "can count total games in one season" do
            expect(@stat_tracker.count_of_games_by_season).to eq ({"20122013" => 10, "20162017" => 4, "20142015" => 3})
        end

    end

    describe "#average_goals_per_game" do
        it "can determine average goals of a all games" do
            expect(@stat_tracker.average_goals_per_game).to eq (4.06) #rounded from 4.0588...
        end
    end

    describe "#average_goals_by_season" do
        it "can determine average goals of all games in a given season" do
            expect(@stat_tracker.average_goals_by_season).to eq ({"20122013" => 3.7, "20162017" => 4.75, "20142015" => 4.33 })
        end
    end

end

require 'CSV'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_stats'
require './lib/league_stats'
require './lib/season_stats'
require './lib/stat_tracker'

RSpec.describe StatTracker do
    before(:all) do 
        @locations = {games: './data/games_fixture.csv', 
        teams: './data/teams.csv', 
        game_teams: './data/game_teams_fixture.csv'}
        
        @stat_tracker = StatTracker.from_csv(@locations)
    end

    describe '#highest_total_score' do
        it 'can find the highest sum of winning and losing teams scores' do 
            expect(@stat_tracker.highest_total_score).to eq 5
        end
    end

    describe '#lowest_total_score' do
        it 'can find the lowest sum of winning and losing teams scores' do
            expect(@stat_tracker.lowest_total_score).to eq 1
        end
    end

    describe '#percentage_home_wins' do
        it 'can calculate home team wins percentage' do
            expect(@stat_tracker.percentage_home_wins).to eq (0.46)
        end
    end

    describe '#percentage_visitor_wins' do
        it 'can calculate visitor team wins percentage' do
            expect(@stat_tracker.percentage_visitor_wins).to eq (0.46)
        end
    end

    describe '#percentage_ties' do
        it 'can calculate percentage of tie games' do
            expect(@stat_tracker.percentage_ties).to eq (0.08)
        end
    end

    describe '#away_winners' do
        it 'can count away wins' do
            expect(@stat_tracker.away_winners).to eq 6
        end
    end

    describe '#home_winners' do
        it 'can count home wins' do
            expect(@stat_tracker.home_winners).to eq 6
        end
    end

    describe '#tie_games' do
        it 'can count tie games' do
            expect(@stat_tracker.tie_games).to eq 1
        end
    end

end