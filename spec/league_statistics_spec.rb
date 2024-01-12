RSpec.describe LeagueStatistics do
  before :each do
  @game_teams = [
      { game_id: 2012030221, team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7 },
      { game_id: 2012030221, team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5 },
      { game_id: 2012030222, team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4 },
      { game_id: 2012030222, team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 3, shots: 8, tackles: 36, pim: 19, powerPlayOpportunities: 1, powerPlayGoals: 0, faceOffWinPercentage: 48.3, giveaways: 16, takeaways: 6 }
      # Add more game_teams if needed
    ]
  @teams = [
      { team_id: 1, franchiseId: 23, teamName: 'Atlanta United', abbreviation: 'ATL', Stadium: 'Mercedes-Benz Stadium', link: '/api/v1/teams/1' },
      { team_id: 4, franchiseId: 16, teamName: 'Chicago Fire', abbreviation: 'CHI', Stadium: 'SeatGeek Stadium', link: '/api/v1/teams/4' },
      { team_id: 26, franchiseId: 14, teamName: 'FC Cincinnati', abbreviation: 'CIN', Stadium: 'Nippert Stadium', link: '/api/v1/teams/26' },
      { team_id: 14, franchiseId: 31, teamName: 'DC United', abbreviation: 'DC', Stadium: 'Audi Field', link: '/api/v1/teams/14' }
    ]
  end

  let(:game_teams_filepath) {'./data/game_teams_sample.csv'}
  let(:teams_filepath) {'./data/teams_sample.csv'}
  let(:league_stats) {LeagueStatistics.from_csv(game_teams_filepath, teams_filepath)}

  describe '.from_csv' do
    it 'creates a LeagueStatistics instance from CSV file' do
      expect(league_stats.teams).to be_a(Array)
      expect(league_stats.game_teams).to be_a(Array)
      expect(league_stats.teams.length).to eq(4)
      expect(league_stats.game_teams.length).to eq(4)
    end
  end
end
