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
        xit 'can find the highest sum of winning and losing teams scores' do 
            expect(@stat_tracker.highest_total_score("20122013")).to eq 14
        end
    end

    describe '#lowest_total_score' do
        xit 'can find the lowest sum of winning and losing teams scores' do
            expect(@stat_tracker.lowest_total_score("20122013")).to eq 12
        end
    end

    describe '#percentage_home_wins' do
        it 'can calculate home team wins percentage' do
            expect(@stat_tracker.percentage_home_wins("20122013")).to eq (0.55)
        end
    end

    describe '#percentage_visitor_wins' do
        it 'can calculate visitor team wins percentage' do
            expect(@stat_tracker.percentage_visitor_wins("20122013")).to eq (0.36)
        end
    end

    describe '#percentage_ties' do
        it 'can calculate percentage of tie games' do
            expect(@stat_tracker.percentage_ties("20122013")).to eq (0.09)
        end
    end

    describe '#count_of_games_by_season' do
        xit 'can count games in a season' do
            expect(@stat_tracker.count_of_games_by_season("20122013")).to eq # need to do math
        end
    end

    describe '#average_goals_per_game' do
        xit 'can calculate the average amount of goals per game' do
            expect(@stat_tracker.average_goals_per_game(game id goes here)).to eq # need to do math
        end
    end

    describe '#average_goals_by_season' do
        xit 'can calculate the average amount of goals in a season' do
            expect(@stat_tracker.count_of_goals_by_season("20122013")).to eq # need to do math
        end
    end

end