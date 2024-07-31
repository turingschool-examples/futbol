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

    describe 'highest_total_score' do
        it 'returns highest sum of the winning and losing teams scores' do
            expect(@stat_tracker.highest_total_score).to eq(5)
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

end