require 'spec_helper'

RSpec.describe League do
  before(:each) do
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    tracker = StatTracker.from_csv(locations)
    @teams = Team.new(team_path, tracker)  #need to get this right depending on what we are calling it in stattracker
  end

    describe 'ititalize' do
        it 'exists' do
            expect(@teams).to be_a(Team)
        end
    end

    describe 'team_count' do
        xit 'can count the number of teams in the data' do
            expect(@league.count_of_teams).to eq() #integer
        end
    end

    describe 'best_offense' do
        xit 'can name the team with the highest average goals per game across all seasons' do
            expect(@league.best_offense).to eq() #string
        end
    end

    describe 'worst_offense' do
        xit 'can name the team with the lowest avg number of goals scored per game across all seasons' do
            expect(@league.worst_offense).to eq() #string
        end
    end

    describe 'highest_scoring_visitor' do
        xit 'can name the team with the highest avg score per game when they are away' do
            expect(@league.highest_scoring_visitor).to eq() #string
        end
    end

    describe 'highest_scoring_home_team' do
        xit 'can name the team with the highest avg score per game when they are home' do
            expect(@league.highest_scoring_home_team).to eq() #string
        end
    end

    describe 'lowest_scoring_visitor' do
        xit 'can name the team with the lowest avg score per game when they are a vistor' do
            expect(@league.lowest_scoring_visitor).to eq() #string
        end
    end

    describe 'lowest_scoring_home_team' do
        xit 'can name the team with the lowest avg score per game when they are at home' do
            expect(@league.lowest_scoring_home_team).to eq() #string


        end
    end


        
end