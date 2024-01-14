require 'spec_helper'

RSpec.describe StatTrackerCalculator do
    before do 
        @stat_tracker_calc = StatTrackerCalculator.new
        @game_path = './data/games.csv'
        @team_path = './data/teams.csv'
        @game_teams_path = './data/game_teams.csv'
        @locations = { games: @game_path, teams: @team_path, game_teams: @game_teams_path }
        @season = '20122013'
    end
    describe 'initialize' do
        it 'exists' do
            expect(@stat_tracker_calc).to be_(StatTrackerCalculator)

        end
    
        it 'starts with empty attributes' do
            expect(@stat_tracker_calc.game_path).to eq('')
            expect(@stat_tracker_calc.team_path).to eq('')
            expect(@stat_tracker_calc.game_teams_path).to eq('')
        end

    end

    describe '#from_csv' do
        it 'will set the file paths for game, team, and game_teams atrributes and return a new instance of stat_tracker_calc' do
            expect(stat_tracker_calc.from_csv(@locations)).to be_a(StatTrackerCalculator)
            expect(@stat_tracker_calc.game_path).to eq(@game_path)
            expect(@stat_tracker_calc.team_path).to eq(@team_path)
            expect(@stat_tracker_calc.game_teams_path).to eq(@game_teams_path)
        end
    end

    describe '#make_factories' do
        it 'creates the factories for game, team, and game_team classes' do
            @stat_tracker_calc.make_factories

            expect(@stat_tracker_calc.game_factory).to be_a(GameFactory)
            expect(@stat_tracker_calc.team_factory).to be_a(TeamFactory)
            expect(@stat_tracker_calc.game_team_factory).to be_a(GameTeamFactory)
        end
    end

    describe 'highest_total_score' do

        it 'returns an integer' do
            expect(@stat_tracker_calc.highest_total_score.class).to be_a(Integer)
        end

        it 'returns the highest sum of the winning and losing teams scores' do
            
            expect(@stat_tracker_calc.highest_total_score).to eq(5)
        end
    end

    describe 'lowest_total_score' do
        
        it 'returns an integer' do
            expect(@stat_tracker_calc.lowest_total_score.class).to be_a(Integer)
        end

        it 'returns the lowest sum of the winning and losing teams scores' do
            expect(@stat_tracker_calc.lowest_total_score).to eq(1)
        end
    end

    describe 'percentage_home_wins' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_home_wins.class).to be_a(Float)
        end

        it 'returns the percentage of games that a home team has won' do
            expect(@stat_tracker_calc.percentage_home_wins).to eq(48.00)
        end

    describe 'percentage_visitor_wins' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_visitor_wins.class).to be_a(Float)
        end

        it 'returns the percentage of games that a visitor team has won' do
            expect(@stat_tracker_calc.percentage_visitor_wins).to eq(16.00)
        end
    end

    describe 'percentage_ties' do

        it 'returns a float' do
            expect(@stat_tracker_calc.percentage_ties.class).to be_a(Float)
        end

        it 'returns the percentage of games that has resulted in a tie' do
            expect(@stat_tracker_calc.percentage_ties).to eq(16.00)
        end
    end
    
    describe 'count_of_games_by_season' do

        it 'returns a hash with season as keys and the number of games as values' do
            games_by_season = @stat_tracker_calc.count_of_games_by_season

            expect(games_by_season).to be_a(Hash)

            expect(games_by_season).to eq({20122013 => 20, 20172018 => 3, 20162017 => 2})
        end
    end

    describe 'average_goals_per_game' do

        it 'returns a float with average number of goals scored per game across all seasons' do
            average_goals_per_game = @stat_tracker_calc.average_goals_per_game

            expect(average_goals_per_game).to be_a(Float)

            expect(average_goals_per_game).to eq(3.88)
        end
    end

    describe 'average_goals_by_season' do

        it 'returns a hash with the keys being season name and the values being the average number of goals scored in a game for that season' do
            average_goals_by_season = @stat_tracker_calc.average_goals_by_season

            expect(average_goals_by_season).to be_a(Hash)

            expect(average_goals_by_season).to eq({ 20122013 => 3.75, 20172018 => 4.0, 20162017 => 5.0 })
        end
    end

    describe 'count_of_teams' do

        it 'returns an integer' do
            expect(@stat_tracker_calc.count_of_teams).to be_a(Integer)
        end

        it 'returns an integer of the total amount of teams' do
            expect(@stat_tracker_calc.count_of_teams).to eq(32)
        end
    end

    describe 'best_offense' do

        it 'returns a string' do
            expect(@stat_tracker_calc.best_offense).to be_a(String)
        end

        it 'returns the name of the team with the best offense' do
            expect(@stat_tracker_calc.best_offense).to eq('Sky Blue FC')
        end
    end

    describe 'worst_offense' do

        it 'returns a string' do
            expect(@stat_tracker_calc.worst_offense).to be_a(String)
        end

        it 'returns the name of the team with the worst offense' do
            expect(@stat_tracker_calc.worst_offense).to eq('Sporting Kansas City')
        end
    end

    describe 'highest_scoring_visitor' do

        it 'returns a string' do
            expect(@stat_tracker_calc.highest_scoring_visitor).to be_a(String)
        end

        it 'returns the name of the team with highest average score per game when they are away' do
            expect(@stat_tracker_calc.highest_scoring_visitor).to eq('FC Dallas')
        end
    end

    describe 'lowest_scoring_visitor' do

        it 'returns a string' do
            expect(@stat_tracker_calc.lowest_scoring_visitor).to be_a(String)
        end

        it 'returns the name of the team with lowest average score per game across all seasons when they are away' do
            expect(@stat_tracker_calc.lowest_scoring_visitor).to eq('New England Revolution')
        end
    end

    describe 'highest_scoring_home_team' do

        it 'returns a string' do
            expect(@stat_tracker_calc.highest_scoring_home_team).to be_a(String)
        end

        it 'return the name of the team with the highest average score per game across all seasons when they are home' do
            expect(@stat_tracker_calc.highest_scoring_home_team).to eq('New York City FC')
        end
    end

    describe 'lowest_scoring_home_team' do

        it 'returns a string' do
            expect(@stat_tracker_calc.lowest_scoring_home_team).to be_a(String)
        end

        it 'return the name of the team with the lowest average score per game across all seasons when they are home' do
            expect(@stat_tracker_calc.lowest_scoring_home_team).to eq('Sporting Kansas City')
        end
    end

    describe 'winningest_coach(season)' do
        it 'returns a string' do
            expect(@stat_tracker_calc.winningest_coach(@season)).to be_a(String)
        end

        it 'returns the name of the coach with the best win percentage for the season' do
            expect(@stat_tracker_calc.winningest_coach(@season)).to eq('Claude Julien')
        end
    end
        
    describe 'worst_coach(season)' do
        it 'returns a string' do
            expect(@stat_tracker_calc.worst_coach(@season)).to be_a(String)
        end

        it 'returns the name of the coach with the worst win percentage for the season' do
            expect(@stat_tracker_calc.worst_coach(@season)).to eq('John Tortorella')
        end
    end

    describe 'most_accurate_team' do
        it 'returns a string' do
            expect(@stat_tracker_calc.most_accurate_team(@season)).to be_a(String)
        end

        it 'returns the name of the team with the best ratio of shots to goals for the season' do
            expect(@stat_tracker_calc.most_accurate_team(@season)).to eq('FC Dallas')
        end
    end

    describe 'least_accurate_team' do
        it 'returns a string' do
            expect(@stat_tracker_calc.least_accurate_team(@season)).to be_a(String)
        end

        it 'returns the name of the team with the worst ratio of shots to goals for the season' do
            expect(@stat_tracker_calc.least_accurate_team(@season)).to eq('Sporting Kansas City')
        end
    end

    describe 'most_tackles' do
        it 'returns a string' do
            expect(@stat_tracker_calc.most_tackles(@season)).to be_a(String)
        end

        it 'returns the name of the team with the most tackles in the season' do
            expect(@stat_tracker_calc.most_tackles(@season)).to eq('FC Dallas')
        end
    end

    describe 'fewest_tackles' do
        it 'returns a string' do
            expect(@stat_tracker_calc.fewest_tackles(@season)).to be_a(String)
        end

        it 'returns the name of the team with the fewest tackles in the season' do
            expect(@stat_tracker_calc.fewest_tackles(@season)).to eq('New England Revolution')
        end
    end
end