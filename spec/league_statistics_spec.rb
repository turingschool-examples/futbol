RSpec.describe LeagueStatistics do
  let(:game_teams_filepath) {'./data/game_teams_sample.csv'}
  let(:teams_filepath) {'./data/teams_sample.csv'}
  let(:league_stats) {LeagueStatistics.from_csv(game_teams_filepath, teams_filepath)}

  describe '.from_csv' do
    it 'creates a LeagueStatistics instance from CSV file' do
      expect(league_stats.teams).to be_a(Array)
      expect(league_stats.game_teams).to be_a(Array)
      expect(league_stats.teams.length).to eq(6)
      expect(league_stats.game_teams.length).to eq(4)
    end
  end

  describe '#count_of_teams' do
    it 'can count all the teams' do
      expect(league_stats.count_of_teams).to eq(6)
    end
  end

  describe '#best_offense' do
    it 'returns the best offense' do
      expect(league_stats.best_offense).to eq('FC Dallas')
    end
  end

  describe '#worst_offense' do
    it 'returns the name of the team with the lowest average number of goals scored per game' do
      expect(league_stats.worst_offense).to eq('Houston Dynamo')
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns the highest scoring visitor' do
      expect(league_stats.highest_scoring_visitor).to eq('Houston Dynamo')
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the lowest scoring visitor' do
      expect(league_stats.lowest_scoring_visitor).to eq('Houston Dynamo')
    end
  end
end
