RSpec.describe LeagueStatistics do
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
