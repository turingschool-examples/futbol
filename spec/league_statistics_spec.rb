RSpec.describe LeagueStatistics do
  before :each do
  @game_teams = [
      { game_id: 2012030221, team_id: 3, hoa: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerplayopportunities: 3, powerplaygoals: 0, facepffwinpercentage: 44.8, giveaways: 17, takeaways: 7 },
      { game_id: 2012030221, team_id: 6, hoa: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerplayopportunities: 4, powerplaygoals: 1, facepffwinpercentage: 55.2, giveaways: 4, takeaways: 5 },
      { game_id: 2012030222, team_id: 3, hoa: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerplayopportunities: 5, powerplaygoals: 0, facepffwinpercentage: 51.7, giveaways: 1, takeaways: 4 },
      { game_id: 2012030222, team_id: 6, hoa: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 3, shots: 8, tackles: 36, pim: 19, powerplayopportunities: 1, powerplaygoals: 0, facepffwinpercentage: 48.3, giveaways: 16, takeaways: 6 }
    ]
  @teams = [
      { team_id: 1, franchiseid: 23, teamname: 'Atlanta United', abbreviation: 'ATL', stadium: 'Mercedes-Benz Stadium', link: '/api/v1/teams/1' },
      { team_id: 4, franchiseid: 16, teamname: 'Chicago Fire', abbreviation: 'CHI', stadium: 'SeatGeek Stadium', link: '/api/v1/teams/4' },
      { team_id: 26, franchiseid: 14, teamname: 'FC Cincinnati', abbreviation: 'CIN', stadium: 'Nippert Stadium', link: '/api/v1/teams/26' },
      { team_id: 14, franchiseid: 31, teamname: 'DC United', abbreviation: 'DC', stadium: 'Audi Field', link: '/api/v1/teams/14' }
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
