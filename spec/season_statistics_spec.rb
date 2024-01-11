RSpec.describe SeasonStatistics do
  let(:game_teams_filepath) {'./data/game_teams_sample.csv'}
  let(:games_filepath) {'./data/games_sample.csv'}
  let(:season_stats) {SeasonStatistics.from_csv(games_filepath, game_teams_filepath)}

  describe '.from_csv' do
    it 'creates a SeasonStatistics instance from CSV file' do
      expect(season_stats.games).to be_a(Array)
      expect(season_stats.game_teams).to be_a(Array)
      expect(season_stats.games.length).to eq(4)
      expect(season_stats.game_teams.length).to eq(4)
    end
  end

end
