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

  describe '#load_game_data' do
    it 'loads game data from a CSV file' do
      mocked_csv_data = <<-CSV
        game_id,team_id,HoA,result,settled_in,head_coach,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways
        2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7
        2012030221,6,home,WIN,OT,Claude Julien,3,12,51,6,4,1,55.2,4,5
        2012030222,3,away,LOSS,REG,John Tortorella,2,9,33,11,5,0,51.7,1,4
        2012030222,6,home,WIN,REG,Claude Julien,3,8,36,19,1,0,48.3,16,6
        2012030223,6,away,WIN,REG,Claude Julien,2,8,28,6,0,0,61.8,10,7
        2012030223,3,home,LOSS,REG,John Tortorella,1,6,37,2,2,0,38.2,7,9
        2012030224,6,away,WIN,OT,Claude Julien,3,10,24,8,4,2,53.7,8,6
        2012030224,3,home,LOSS,OT,John Tortorella,2,8,40,8,4,1,46.3,9,7
      CSV

      csv_file = StringIO.new(mocked_csv_data)
      allow(CSV).to receive(:read).and_return(CSV.parse(csv_file, headers: true, header_converters: :symbol))

      @season_stats.load_game_data('path/to/mock_file.csv')

      expect(@season_stats.game_data.length).to eq(8)
      expect(@season_stats.game_data.first[:head_coach]).to eq('John Tortorella')
    end
  end

  describe '#load_team_data' do
    it 'loads team data from a CSV file' do
      mocked_team_csv_data = <<-CSV
        team_id,franchiseId,teamName,abbreviation,Stadium,link
        3,10,Houston Dynamo,HOU,BBVA Stadium,/api/v1/teams/3
        6,6,FC Dallas,DAL,Toyota Stadium,/api/v1/teams/6
      CSV

      csv_file = StringIO.new(mocked_team_csv_data)
      allow(CSV).to receive(:read).and_return(CSV.parse(csv_file, headers: true, header_converters: :symbol))

      @season_stats.load_team_data('path/to/mock_team_file.csv')

      expect(@season_stats.team_data.length).to eq(2)
      expect(@season_stats.team_data.first[:teamName]).to eq('Houston Dynamo')
    end
  end

end