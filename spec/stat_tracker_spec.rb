require 'spec_helper'


RSpec.describe StatTracker do
    before(:each) do
        game_path = './data/games_dummy.csv'
        team_path = './data/teams_dummy.csv'
        game_teams_path = './data/game_teams_dummy.csv'

        @locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
            }

        @stat_tracker = StatTracker.from_csv(@locations)
    end

    describe "initialize" do
        it 'exists' do
            expect(@stat_tracker).to be_an_instance_of StatTracker
        end
    
    end

    describe "game_reader" do
        it "returns a hash with keys set to game_id, value is the relevant game object" do
            games_data = StatTracker.game_reader(@locations[:games])

            expect(games_data.class).to eq Hash
            expect(games_data[2012030221]).to be_an_instance_of Game
        end

        it "each game object it creates, all their attributes are truthy" do
            games_data = StatTracker.game_reader(@locations[:games])
            
            games_data.each do |game_id, game_object|
                game_object.instance_variables.each do |instance_variable|
                    expect(game_object.instance_variable_get(instance_variable)).to be_truthy
                end
            end
        end

        it "creates a game object for reach row" do
            games_data = StatTracker.game_reader(@locations[:games])
            row_count = CSV.read(@locations[:games], headers: true).size

            expect(games_data.length).to eq(row_count)
        end
    end

    describe "teams_reader" do
        it "returns a hash with keys set to team_id, value is the relevant team object" do
            teams_data = StatTracker.teams_reader(@locations[:teams])

            expect(teams_data.class).to eq Hash
            expect(teams_data[1]).to be_an_instance_of Team
        end

        it "each team object it creates, all their attributes are truthy" do
            teams_data = StatTracker.teams_reader(@locations[:teams])
            
            teams_data.each do |team_id, team_object|
                team_object.instance_variables.each do |instance_variable|
                    expect(team_object.instance_variable_get(instance_variable)).to be_truthy
                end
            end
        end

        it "creates a team object for each row" do
            teams_data = StatTracker.teams_reader(@locations[:teams])
            row_count = CSV.read(@locations[:teams], headers: true).size

            expect(teams_data.length).to eq(row_count)
        end
    end

    describe "game_teams_reader" do
        it "returns a hash with keys set to game_id, value is the relevant season object" do
            seasons_data = StatTracker.game_teams_reader(@locations[:game_teams])

            expect(seasons_data.class).to eq Hash
            expect(seasons_data[1]).to be_an_instance_of Season
        end

        it "each season object it creates, all their attributes are truthy" do
            seasons_data = StatTracker.game_teams_reader(@locations[:game_teams])
            
            seasons_data.each do |game_id, season_object|
                season_object.instance_variables.each do |instance_variable|
                    expect(season_object.instance_variable_get(instance_variable)).to be_truthy
                end
            end
        end

        it "creates a season object for each row" do
            seasons_data = StatTracker.game_teams_reader(@locations[:game_teams])
            row_count = CSV.read(@locations[:game_teams], headers: true).size

            expect(seasons_data.length).to eq(row_count)
        end
    end

    describe 'highest_total_score' do
        it 'returns highest sum of the winning and losing teams scores' do
            expect(@stat_tracker.highest_total_score).to eq(5)
        end
    end

    describe 'lowest_total_score' do
        it 'returns lowest sum of the winning and losing teams scores' do
            expect(@stat_tracker.lowest_total_score).to eq(1)
        end
    end

    describe 'percentage_home_wins' do
        it 'returns percentage of games that a home team has won' do
            expect(@stat_tracker.percentage_home_wins).to eq(0.64)
        end
    end

    describe 'percentage_ties' do
        it 'returns percentage of games that has resulted in a tie (rounded to the nearest 100th)' do 
            expect(@stat_tracker.percentage_ties).to eq(0.00) # NO TIES CURRENTLY LISTED

            hash_of_games = @stat_tracker.instance_variable_get(:@game_stats_data)

            hash_of_games[2012030221].instance_variable_set(:@away_goals, 15) 
            hash_of_games[2012030221].instance_variable_set(:@home_goals, 15) 

            expect(@stat_tracker.percentage_ties).to eq(0.07)

            hash_of_games[2012030222].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030222].instance_variable_set(:@home_goals, 15)
            
            hash_of_games[2012030223].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030223].instance_variable_set(:@home_goals, 15)

            hash_of_games[2012030224].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030224].instance_variable_set(:@home_goals, 15)
            
            hash_of_games[2012030225].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030225].instance_variable_set(:@home_goals, 15)

            hash_of_games[2012030311].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030311].instance_variable_set(:@home_goals, 15)

            hash_of_games[2012030312].instance_variable_set(:@away_goals, 15)
            hash_of_games[2012030312].instance_variable_set(:@home_goals, 15) # UPDATE DATA SO TIES AND WINS ARE 50/50

            expect(@stat_tracker.percentage_ties).to eq(0.50)
        end
    end

    describe 'average_goals_per_game' do
        it 'can find the average amount of goals per game for entire season' do
            expect(@stat_tracker.average_goals_per_game).to eq(3.5)

            hash_of_games = @stat_tracker.instance_variable_get(:@game_stats_data)

            hash_of_games[2012030222].instance_variable_set(:@away_goals, 329)

            expect(@stat_tracker.average_goals_per_game).to eq(26.86)
        end
        
    end

    describe 'count_of_teams' do
        it 'returns the total number of teams' do
            expect(@stat_tracker.count_of_teams).to eq(14)
        end
    end

    describe 'team_seasons_goals' do
        it "returns a hash with each team as the key, and the value a hash with :goals & :games_played as keys, and their respective values" do
            expect(@stat_tracker.team_seasons_goals).to eq ({3=>{:goals=>8, :games_played=>5}, 6=>{:goals=>21, :games_played=>7}, 5=>{:goals=>1, :games_played=>2}})
        end
    end

    describe 'best_offense' do
        it 'returns name from id' do
            @teams_stats_data = StatTracker.teams_reader(@locations[:teams])
            @teams_stats_data.each do |team_id, team_object|
                expect(@stat_tracker.id_to_name(team_id)).to eq(team_object.team_name)
            end
        end

        it 'returns team yielding highest goals scored per game over all seasons' do
            expect(@stat_tracker.best_offense).to eq('FC Dallas')
        end
    end

    # describe 'worst_offense' do

    # end
    
    describe 'highest_scoring_visitor' do
        it 'returns name of the team with the highest average score per game across all seasons when they are away.' do
            expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
        end
    end
    
    # describe 'highest_scoring_home_team' do

    # end
    
    describe 'lowest_scoring_visitor' do
        it 'returns lowest average scoring team when they are a visitor.' do
            expect(@stat_tracker.lowest_scoring_visitor).to eq('Sporting Kansas City')
        end
    end
    
    # describe 'lowest_scoring_home_team' do

    # end
    
    # describe 'winningest_coach' do

    # end
    
    xdescribe 'worst_coach' do
        it 'returns coach with worst win percentage for the season' do
            expect(@stat_tracker.worst_coach).to eq('ur mom')
        end
    end
    
    # describe 'most_accurate_team' do

    # end
    
    describe 'least_accurate_team' do
        it 'returns name of the Team with the worst ratio of shots to goals for the season.' do
            expect(@stat_tracker.least_accurate_team('20122013')).to eq('Sporting Kansas City')
            #expect(@stat_tracker.least_accurate_team(20132014)).to eq "New York City FC"
            #expect(@stat_tracker.least_accurate_team(20142015)).to eq "Columbus Crew SC"
        end
    end
    
    # describe 'most_tackles' do

    # end
    
    describe 'fewest_tackles' do
        it 'returns name of the Team with the fewest tackles in the season' do
            expect(@stat_tracker.fewest_tackles('20122013')).to eq("Sporting Kansas City")
        end
    end
end