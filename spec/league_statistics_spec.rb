require 'rspec'

RSpec.describe LeagueStatistics do 
  before(:each) do 
    @fake_game_data = [
        { game_id: '2012030221', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7 },
        { game_id: '2012030221', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5 },
        { game_id: '2012030222', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4 },
        { game_id: '2012030222', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 3, shots: 8, tackles: 36, pim: 19, powerPlayOpportunities: 1, powerPlayGoals: 0, faceOffWinPercentage: 48.3, giveaways: 16, takeaways: 6 }
        ]

        @fake_team_data = [
        { team_id: 6, franchiseId: 6, teamName: 'FC Dallas', abbreviation: 'DAL', Stadium: 'Toyota Stadium', link: '/api/v1/teams/6' },
        { team_id: 3, franchiseId: 10, teamName: 'Houston Dynamo', abbreviation: 'HOU', Stadium: 'BBVA Stadium', link: '/api/v1/teams/3' }
        ]      
    
        @league_statistics = LeagueStatistics.new(@fake_game_data, @fake_team_data) 
  end
  
  describe 'count_of_teams' do
    it 'counts the number of teams' do
      allow(@league_statistics).to receive(:count_of_teams).and_return(2)
      expect(@league_statistics.count_of_teams).to eq(2)
    end
  end

  describe 'best_offense' do
    it 'returns the team with the highest average number of goals per game' do
      allow(@league_statistics).to receive(:best_offense).and_return('FC Dallas')
      expect(@league_statistics.best_offense).to eq('FC Dallas')
    end
  end

  describe 'worst_offense' do
    it 'returns the team with the lowest average number of goals per game' do
      allow(@league_statistics).to receive(:worst_offense).and_return('Houston Dynamo')
      expect(@league_statistics.worst_offense).to eq('Houston Dynamo')
    end
  end

  describe 'highest_scoring_visitor' do
    it 'returns the team with the highest average score when they are away' do
      allow(@league_statistics).to receive(:highest_scoring_visitor).and_return('FC Dallas')
      expect(@league_statistics.highest_scoring_visitor).to eq('FC Dallas')
    end
  end

  describe 'highest_scoring_home_team' do
    it 'returns the team with the highest average score when they are home' do
      allow(@league_statistics).to receive(:highest_scoring_home_team).and_return('FC Dallas')
      expect(@league_statistics.highest_scoring_home_team).to eq('FC Dallas')
    end
  end

  describe 'lowest_scoring_visitor' do
    it 'returns the team with the lowest average score when they are away' do
      allow(@league_statistics).to receive(:lowest_scoring_visitor).and_return('Houston Dynamo')
      expect(@league_statistics.lowest_scoring_visitor).to eq('Houston Dynamo')
    end
  end

  describe 'lowest_scoring_home_team' do
    it 'returns the team with the lowest average score when they are home' do
      allow(@league_statistics).to receive(:lowest_scoring_home_team).and_return('Houston Dynamo')
      expect(@league_statistics.lowest_scoring_home_team).to eq('Houston Dynamo')
    end
  end
end