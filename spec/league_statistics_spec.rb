require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe LeagueStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)

        @games = CSV.read('./data/games_spec.csv', headers: true, header_converters: :symbol)
        @team_path = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
        @game_teams = CSV.read('./data/game_teams_spec.csv', headers: true, header_converters: :symbol)

        @league_statistics = LeagueStatistics.new(@games, @team_path, @game_teams)
      end

    describe '#initialize' do
        it 'exists' do

            expect(@league_statistics).to be_a(LeagueStatistics)
        end

        it '#attributes' do

            expect(@league_statistics.games).not_to be_empty
            expect(@league_statistics.teams).not_to be_empty
            expect(@league_statistics.game_teams).not_to be_empty
        end
    end

    describe '#team_name' do
        it 'returns the correct team name when given a valid team ID' do
            
            expect(@league_statistics.team_name('6')).to eq('FC Dallas')
            expect(@league_statistics.team_name('3')).to eq('Houston Dynamo')
        end

        it 'returns "Unknown Team" when given an invalid team ID' do
            
            expect(@league_statistics.team_name('99999')).to eq('Unknown Team') # Fake ID
        end
    end

    describe '#calculate_avg-goals' do
        it 'correctly calculates average goals per game for a team' do

            expect(@league_statistics.calculate_avg_goals('6')).to eq(2.8)
            expect(@league_statistics.calculate_avg_goals('3')).to eq(1.6) #Rounded down
        end

        it 'returns 0.0 if the team has played no games' do

            expect(@league_statistics.calculate_avg_goals('99999')).to eq(0.0) #Fake ID
        end
    end

    describe '#team_avg_goals_by_hoa' do
        it 'correctly calculates the avg goals per game for home teams' do
            
            expected_home_avg = {
                "FC Dallas" => 3.0, 
                "Houston Dynamo" => 1.5
            }

            expect(@league_statistics.team_avg_goals_by_hoa('home')).to eq(expected_home_avg)
        end

        it 'correctly calculates the avg goals per game for the away teams' do
            
            expected_away_avg = {
                "Houston Dynamo" => 1.67, 
                "FC Dallas" => 2.5
            }

            expect(@league_statistics.team_avg_goals_by_hoa('away')).to eq(expected_away_avg)
        end

        it 'returns an empty hash if no teams have played in the given category' do

            @league_statistics.instance_variable_set(:@games, []) #trying to stub no games played, had to research a new stub method to directly hit the instance variable.

            expect(@league_statistics.team_avg_goals_by_hoa('home')).to eq({})
            expect(@league_statistics.team_avg_goals_by_hoa('away')).to eq({})
        end
    end

    describe '#highest_avg_team' do
        it 'can calculate the highest avg goals scored' do

            expect(@league_statistics.highest_avg_team(:max_by)).to eq('FC Dallas')
        end
        
    end

    describe '#lowest_avg_team' do
        it 'can calculate the lowest avg goals scored' do

            expect(@league_statistics.lowest_avg_team(:min_by)).to eq('Houston Dynamo')
        end
    
    end

    describe '#highest_avg_team_by_hoa' do
        it 'can calculate highest avg goals scored when home' do

            expect(@league_statistics.highest_avg_team_by_hoa('home', :max_by)).to eq('FC Dallas')
        end

        it 'can calculate highest avg goals scored when away' do

            expect(@league_statistics.highest_avg_team_by_hoa('away', :max_by)).to eq('FC Dallas')
        end

        it 'can calculate lowest avg goals when home' do

            expect(@league_statistics.highest_avg_team_by_hoa('home', :min_by)).to eq('Houston Dynamo')
        end

        it 'can calculate lowest avg goals when away' do

            expect(@league_statistics.highest_avg_team_by_hoa('away', :min_by)).to eq('Houston Dynamo')
        end
    end

    describe '#count_of_teams' do
        it 'returns the total number of teams' do

            expect(@league_statistics.count_of_teams).to eq(32)
        end
    end

    describe '#best_offense' do #May want to stub
        it 'returns the team with the highest average goals scored per game' do

            expect(@league_statistics.best_offense).to eq('FC Dallas') # From fixture
        end
    end

    describe '#worst_offense' do
        it 'returns the team with the lowest average goals scored per game' do

            expect(@league_statistics.worst_offense).to eq("Houston Dynamo") # From fixture
        end
    end

    describe '#highest_scoring_visitor' do
        it 'returns the team with the highest average score per game when away' do

            expect(@league_statistics.highest_scoring_visitor).to eq("FC Dallas")
        end
    end

    describe '#highest_scoring_home_team' do
        it 'returns the team with the highest average score per game when at home' do

            expect(@league_statistics.highest_scoring_home_team).to eq('FC Dallas')
        end
    end

    describe '#lowest_scoring_visitor' do
        it 'returns the team with the lowest average score per game when away' do

            expect(@league_statistics.lowest_scoring_visitor).to eq('Houston Dynamo')
        end
    end

    describe '#lowest_scoring_home_team' do
        it 'returns the team with the lowest average score per game when at home' do

            expect(@league_statistics.lowest_scoring_home_team).to eq('Houston Dynamo')
        end
    end
end