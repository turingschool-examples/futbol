require 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
    end

RSpec.describe LeagueStats do
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
    @league_stats = tracker.league_stats 
 
end

    describe 'initialize' do
        it 'exists' do
            expect(@league_stats).to be_a(LeagueStats)
        end
    end

    describe 'team_count' do
        it 'can count the number of teams in the data' do
            expect(@league_stats.count_of_teams).to be_an(Integer)
            expect(@league_stats.count_of_teams).to eq(32) 
        end
    end

    describe 'best_offense' do
        it 'can name the team with the highest average goals per game across all seasons' do
            expect(@league_stats.best_offense).to be_a(String) 
            expect(@league_stats.best_offense).to eq("Reign FC") 
        end
    end

    describe 'worst_offense' do
        it 'can name the team with the lowest avg number of goals scored per game across all seasons' do
            expect(@league_stats.worst_offense).to be_a(String)
            expect(@league_stats.worst_offense).to eq("Utah Royals FC")
        end
    end

    describe 'highest_scoring_visitor' do
        it 'can name the team with the highest avg score per game when they are away' do
            expect(@league_stats.highest_scoring_visitor).to be_a(String) 
            expect(@league_stats.highest_scoring_visitor).to eq("FC Dallas") 
        end
    end

    describe 'highest_scoring_home_team' do
        it 'can name the team with the highest avg score per game when they are home' do
            expect(@league_stats.highest_scoring_home_team).to be_a(String)
            expect(@league_stats.highest_scoring_home_team).to eq("Reign FC") 
        end
    end

    describe 'lowest_scoring_visitor' do
        it 'can name the team with the lowest avg score per game when they are a vistor' do
            expect(@league_stats.lowest_scoring_visitor).to be_a(String)
            expect(@league_stats.lowest_scoring_visitor).to eq("San Jose Earthquakes") 
        end
    end

    describe 'lowest_scoring_home_team' do
         it 'can name the team with the lowest avg score per game when they are at home' do
            expect(@league_stats.lowest_scoring_home_team).to be_a(String)
            expect(@league_stats.lowest_scoring_home_team).to eq("Utah Royals FC") 
        end
    end
    
end