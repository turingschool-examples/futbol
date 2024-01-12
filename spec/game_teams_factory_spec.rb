require './lib/game_teams'
require './lib/game_teams_factory'
require 'pry'

RSpec.describe GameTeamFactory do
    before do
        @file_path = './data/game_teams_fixture.csv'
        @game_team_factory = GameTeamFactory.new(@file_path)
    end

    describe '#initialize' do
        it 'exists' do 
        
            expect(@game_team_factory).to be_a(GameTeamFactory)

        end

        it 'has a file path attribute' do

            expect(@game_team_factory.file_path).to eq(@file_path)

        end
    end

    describe '#create_game_team' do
        it 'creates game team objects from the data stored in its file_path attribute' do

            expect(@game_team_factory.create_game_team).to be_a(Array)
            expect(@game_team_factory.create_game_team.all? {|game_team| game_team.class == GameTeam}).to eq(true)

        end

        it 'creates objects with the necessary attributes' do

            expect(@game_team_factory.create_game_team.first.game_id).to eq(2012030221)
            expect(@game_team_factory.create_game_team.first.team_id).to eq(3)
            expect(@game_team_factory.create_game_team.first.hoa).to eq("away")
            expect(@game_team_factory.create_game_team.first.result).to eq("LOSS")
            expect(@game_team_factory.create_game_team.first.settled_in).to eq("OT")
            expect(@game_team_factory.create_game_team.first.head_coach).to eq("John Tortorella")
            expect(@game_team_factory.create_game_team.first.goals).to eq(2)
            expect(@game_team_factory.create_game_team.first.shots).to eq(8)
            expect(@game_team_factory.create_game_team.first.tackles).to eq(44)
            expect(@game_team_factory.create_game_team.first.pim).to eq(8)
            expect(@game_team_factory.create_game_team.first.power_play_opps).to eq(3)
            expect(@game_team_factory.create_game_team.first.power_play_goals).to eq(0)
            expect(@game_team_factory.create_game_team.first.faceoff_win_percent).to eq(44.8)
            expect(@game_team_factory.create_game_team.first.giveaways).to eq(17)
            expect(@game_team_factory.create_game_team.first.takeaways).to eq(7)

        end
    end

    describe '#ratio_of_shots_to_goals_by_team(team_id)' do
        it 'can tell you the ratio of shots to goals by the team id' do
            @game_team_factory.create_game_team

            expect(@game_team_factory.ratio_of_shots_to_goals_by_team(3)).to eq(21.05)
        end
    end

    describe '#ratio_of_shots_to_goals_by_season(season)' do
        it 'can give you a hash with the shot to goal ratio of each team by their team id' do
            @game_team_factory.create_game_team
            
            expect(@game_team_factory.ratio_of_shots_to_goals_by_season(20122013)).to eq({3 => 21.05, 6 => 31.58, 5 => 6.25, 17 => 20.00, 16 => 20.00})
        end
    end
    
    describe '#ratio_of_shots_to_goals' do
    # should edit fixture to test this with multiple seasons
        it 'can tell you the ratio of shots to goals for all teams by all seasons' do
            @game_team_factory.create_game_team

            expect(@game_team_factory.ratio_of_shots_to_goals).to eq({20122013 => {3 => 21.05, 6 => 31.58, 5 => 6.25, 17 => 20.00, 16 => 20.00}})
        end
    end
    
    
    describe '#game_result_by_hoa' do
        it 'returns an array of strings with the team that won (home, away, or tie)' do
            @game_team_factory.create_game_team
            
            expect(@game_team_factory.game_result_by_hoa).to eq(['home', 'home', 'away', 'away', 'home', 'away', 'away', 'home', 'home', 'home'])
        end
    end

    describe '#goals_by_team_and_hoa(team_id, home/away)' do
        it 'returns an array with all of the total goals scored by the team in argument for the games that they were home/away' do
            @game_team_factory.create_game_team


            expect(@game_team_factory.goals_by_team_and_hoa(3, "home")).to eq([1, 2])
            expect(@game_team_factory.goals_by_team_and_hoa(3, "away")).to eq([2, 2, 1])
        end
    end

    
    describe '#win_percentage_by_coach(head_coach)' do
        # should add in some extra data in the fixture file that will give us percentages other than 0 and 100 for more thorough testing
        it 'can tell you the win percentage of the headcoach in the argument' do
            @game_team_factory.create_game_team
            
            expect(@game_team_factory.win_percentage_by_coach("John Tortorella")).to eq(0.00)
            expect(@game_team_factory.win_percentage_by_coach("Claude Julien")).to eq(100.00)
        end
    end

    describe '#win_percentage_by_coach_by_season(season)' do
        it 'can give you a hash with the shot to goal ratio of each team by their team id' do
            @game_team_factory.create_game_team
            
            expect(@game_team_factory.win_percentage_by_coach_by_season(20122013)).to eq({"John Tortorella" => 0.00, "Claude Julien" => 100.00, "Dan Bylsma" => 0.00, "Mike Babcock" => 0.00, "Joel Quenneville" => 100.00})
        end
    end

    describe '#find_coaches_win_percentages' do
        it 'can return a hash with a season as the key and a hash with the key of coach name and their win percentage as the value for the value of the season key' do
            @game_team_factory.create_game_team

            expect(@game_team_factory.find_coaches_win_percentages).to eq({20122013=>{"Claude Julien"=>100.0, "Dan Bylsma"=>0.0, "Joel Quenneville"=>100.0, "John Tortorella"=>0.0, "Mike Babcock"=>0.0}})
        end
    end
end
