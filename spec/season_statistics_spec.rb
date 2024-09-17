require './spec/spec_helper'

RSpec.describe SeasonStatistics do
  before(:each) do
    @fake_game_data = [
      {
      game_id: '2012030221', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7,
      game_id: '2012030221', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5,
      game_id: '2012030222', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4,
      game_id: '2012030222', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 3, shots: 8, tackles: 36, pim: 19, powerPlayOpportunities: 1, powerPlayGoals: 0, faceOffWinPercentage: 48.3, giveaways: 16, takeaways: 6,
      game_id: '2012030223', team_id: 6, HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 2, shots: 8, tackles: 28, pim: 6, powerPlayOpportunities: 0, powerPlayGoals: 0, faceOffWinPercentage: 61.8, giveaways: 10, takeaways: 7,
      game_id: '2012030223', team_id: 3, HoA: 'home', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 1, shots: 6, tackles: 37, pim: 2, powerPlayOpportunities: 2, powerPlayGoals: 0, faceOffWinPercentage: 38.2, giveaways: 7, takeaways: 9,
      game_id: '2012030224', team_id: 6, HoA: 'away', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 10, tackles: 24, pim: 8, powerPlayOpportunities: 4, powerPlayGoals: 2, faceOffWinPercentage: 53.7, giveaways: 8, takeaways: 6,
      game_id: '2012030224', team_id: 3, HoA: 'home', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 40, pim: 8 powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 46.3, giveaways: 9, takeaways: 7
      }
    ]

    @fake_team_data = [
      { team_id: 6, franchiseId: 6, teamName: 'FC Dallas', abbreviation: 'DAL',Stadium: 'Toyota Stadium', link: '/api/v1/teams/6',
      team_id: 3, franchiseId: 10, teamName: 'Houston Dynamo', abbreviation: 'HOU', Stadium: 'BBVA Stadium', link: '/api/v1/teams/3'}
    ]

    @season_stats = SeasonStatistics.new(@fake_game_data, @fake_team_data)
  end

  describe '#coach stats' do
    it 'knows the winningest coach' do
      allow(@season_stats).to receive(:winningest_coach).and_return('Claude Julien')
      expect(@season_stats.winningest_coach).to eq('Claude Julien')
    end

    it 'knows the worst coach' do
      allow(@season_stats).to receive(:worst_coach).and_return('John Tortorella')
      expect(@season_stats.worst_coach).to eq('John Tortorella')
    end
  end

  describe '#accuracy stats' do
    it 'knows the most accurate team' do
      allow(@season_stats).to receive(:most_accurate_team).and_return('FC Dallas')
      expect(@season_stats.most_accurate_team).to eq('FC Dallas')
    end

    it 'knows the least accurate team' do
      allow(@season_stats).to receive(:least_accurate_team).and_return('Houston Dynamo')
      expect(@season_stats.least_accurate_team).to eq('Houston Dynamo')
    end
  end

  describe '#tackle stats' do
    it 'knows the team with the most tackles' do
      allow(@season_stats).to receive(:most_tackles).and_return('Houston Dynamo')
      expect(@season_stats.most_tackles).to eq('Houston Dynamo')
    end

    it 'knows the team with the fewest tackles' do
      allow(@season_stats).to receive(:fewest_tackles).and_return('FC Dallas')
      expect(@season_stats.fewest_tackles).to eq('FC Dallas')
    end
  end
end