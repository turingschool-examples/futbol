require 'spec_helper'

RSpec.describe StatTrackerCalculator do
    describe '#initialize' do
        it 'exists' do
            stat_tracker_calc = StatTrackerCalculator.new
            expect(stat_tracker_calc).to be_a(StatTrackerCalculator)
        end
    end

    before do 
        @game_path = './data/game_fixture.csv'
        @team_path = './data/teams_fixture.csv'
        @game_teams_path = './data/game_teams_fixture.csv'
        @locations = { games: @game_path, teams: @team_path, game_teams: @game_teams_path }
        @season = '20122013'
        @stat_tracker_calc = StatTracker.from_csv(@locations)
    end

    describe 'highest_total_score' do

        it 'returns an integer' do
            expect(@stat_tracker_calc.highest_total_score).to be_a(Integer)
        end

        it 'returns the highest sum of the winning and losing teams scores' do
            
            expect(@stat_tracker_calc.highest_total_score).to eq(5)
        end
    end

    describe 'lowest_total_score' do
        
        it 'returns an integer' do
            expect(@stat_tracker_calc.lowest_total_score).to be_a(Integer)
        end

        it 'returns the lowest sum of the winning and losing teams scores' do
            expect(@stat_tracker_calc.lowest_total_score).to eq(1)
        end
    end

    describe 'percentage_home_wins' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_home_wins).to be_a(Float)
        end

        it 'returns the percentage of games that a home team has won' do
            expect(@stat_tracker_calc.percentage_home_wins).to eq(0.48)
        end

    describe 'percentage_visitor_wins' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_visitor_wins).to be_a(Float)
        end

        it 'returns the percentage of games that a visitor team has won' do
            expect(@stat_tracker_calc.percentage_visitor_wins).to eq(0.16)
        end
    end

    describe 'percentage_ties' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_ties).to be_a(Float)
        end

        it 'returns the percentage of games that has resulted in a tie' do
            expect(@stat_tracker_calc.percentage_ties).to eq(0.16)
        end
    end
    
    describe 'count_of_games_by_season' do

        xit 'returns a hash with season as keys and the number of games as values' do
            games_by_season = @stat_tracker_calc.count_of_games_by_season

            expect(games_by_season).to be_a(Hash)

            expect(games_by_season).to eq({20122013 => 20, 20172018 => 3, 20162017 => 2})
        end
    end

    describe 'average_goals_per_game' do

        xit 'returns a float with average number of goals scored per game across all seasons' do
            average_goals_per_game = @stat_tracker_calc.average_goals_per_game

            expect(average_goals_per_game).to be_a(Float)

            expect(average_goals_per_game).to eq(3.88)
        end
    end

    describe 'average_goals_by_season' do

        xit 'returns a hash with the keys being season name and the values being the average number of goals scored in a game for that season' do
            average_goals_by_season = @stat_tracker_calc.average_goals_by_season

            expect(average_goals_by_season).to be_a(Hash)

            expect(average_goals_by_season).to eq({ 20122013 => 3.75, 20172018 => 4.0, 20162017 => 5.0 })
        end
    end

    describe 'count_of_teams' do

        xit 'returns an integer' do
            expect(@stat_tracker_calc.count_of_teams).to be_a(Integer)
        end

        xit 'returns an integer of the total amount of teams' do
            expect(@stat_tracker_calc.count_of_teams).to eq(32)
        end
    end

    describe 'best_offense' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.best_offense).to be_a(String)
        end

        xit 'returns the name of the team with the best offense' do
            expect(@stat_tracker_calc.best_offense).to eq('Sky Blue FC')
        end
    end

    describe 'worst_offense' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.worst_offense).to be_a(String)
        end

        xit 'returns the name of the team with the worst offense' do
            expect(@stat_tracker_calc.worst_offense).to eq('Sporting Kansas City')
        end
    end

    describe 'highest_scoring_visitor' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.highest_scoring_visitor).to be_a(String)
        end

        xit 'returns the name of the team with highest average score per game when they are away' do
            expect(@stat_tracker_calc.highest_scoring_visitor).to eq('FC Dallas')
        end
    end

    describe 'lowest_scoring_visitor' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.lowest_scoring_visitor).to be_a(String)
        end

        xit 'returns the name of the team with lowest average score per game across all seasons when they are away' do
            expect(@stat_tracker_calc.lowest_scoring_visitor).to eq('New England Revolution')
        end
    end

    describe 'highest_scoring_home_team' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.highest_scoring_home_team).to be_a(String)
        end

        xit 'return the name of the team with the highest average score per game across all seasons when they are home' do
            expect(@stat_tracker_calc.highest_scoring_home_team).to eq('New York City FC')
        end
    end

    describe 'lowest_scoring_home_team' do

        xit 'returns a string' do
            expect(@stat_tracker_calc.lowest_scoring_home_team).to be_a(String)
        end

        xit 'return the name of the team with the lowest average score per game across all seasons when they are home' do
            expect(@stat_tracker_calc.lowest_scoring_home_team).to eq('Sporting Kansas City')
        end
    end

    describe 'winningest_coach(season)' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.winningest_coach(@season)).to be_a(String)
        end

        xit 'returns the name of the coach with the best win percentage for the season' do
            expect(@stat_tracker_calc.winningest_coach(@season)).to eq('Claude Julien')
        end
    end
        
    describe 'worst_coach(season)' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.worst_coach(@season)).to be_a(String)
        end

        xit 'returns the name of the coach with the worst win percentage for the season' do
            expect(@stat_tracker_calc.worst_coach(@season)).to eq('John Tortorella')
        end
    end

    describe 'most_accurate_team' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.most_accurate_team(@season)).to be_a(String)
        end

        xit 'returns the name of the team with the best ratio of shots to goals for the season' do
            expect(@stat_tracker_calc.most_accurate_team(@season)).to eq('FC Dallas')
        end
    end

    describe 'least_accurate_team' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.least_accurate_team(@season)).to be_a(String)
        end

        xit 'returns the name of the team with the worst ratio of shots to goals for the season' do
            expect(@stat_tracker_calc.least_accurate_team(@season)).to eq('Sporting Kansas City')
        end
    end

    describe 'most_tackles' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.most_tackles(@season)).to be_a(String)
        end

        xit 'returns the name of the team with the most tackles in the season' do
            expect(@stat_tracker_calc.most_tackles(@season)).to eq('FC Dallas')
        end
    end

    describe 'fewest_tackles' do
        xit 'returns a string' do
            expect(@stat_tracker_calc.fewest_tackles(@season)).to be_a(String)
        end

        xit 'returns the name of the team with the fewest tackles in the season' do
            expect(@stat_tracker_calc.fewest_tackles(@season)).to eq('New England Revolution')
        end
    end
end
end