require './spec/spec_helper'

RSpec.describe LeagueStatistics do 
  before(:each) do 
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @league_statistics = LeagueStatistics.new(locations[:games], locations[:teams], locations[:game_teams]) 
  end
  
  describe 'count_of_teams' do
    it 'counts the number of teams' do      
      expect(@league_statistics.count_of_teams).to eq(22)
    end
  end

  describe 'best_offense' do
    xit 'returns the team with the highest average number of goals per game' do
      expect(@league_statistics.best_offense).to eq('FC Dallas')
    end
  end

  describe 'worst_offense' do
    xit 'returns the team with the lowest average number of goals per game' do
      expect(@league_statistics.worst_offense).to eq('Houston Dynamo')
    end
  end

  describe 'highest_scoring_visitor' do
    xit 'returns the team with the highest average score when they are away' do
      expect(@league_statistics.highest_scoring_visitor).to eq('FC Dallas')
    end
  end

  describe 'highest_scoring_home_team' do
    xit 'returns the team with the highest average score when they are home' do
      expect(@league_statistics.highest_scoring_home_team).to eq('FC Dallas')
    end
  end

  describe 'lowest_scoring_visitor' do
    xit 'returns the team with the lowest average score when they are away' do
      expect(@league_statistics.lowest_scoring_visitor).to eq('Houston Dynamo')
    end
  end

  describe 'lowest_scoring_home_team' do
    xit 'returns the team with the lowest average score when they are home' do
      expect(@league_statistics.lowest_scoring_home_team).to eq('Houston Dynamo')
    end
  end
end