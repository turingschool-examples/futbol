RSpec.describe SeasonStatistics do
  let(:game_teams_filepath) {'./data/game_teams_sample.csv'}
  let(:games_filepath) {'./data/games_sample.csv'}
  let(:teams_filepath) {'./data/teams_sample.csv'}
  let(:season_stats) {SeasonStatistics.from_csv(games_filepath, game_teams_filepath, teams_filepath)}

  describe '.from_csv' do
    it 'creates a SeasonStatistics instance from CSV file' do
      expect(season_stats.games).to be_a(Array)
      expect(season_stats.teams).to be_a(Array)
      expect(season_stats.game_teams).to be_a(Array)
      expect(season_stats.games.length).to eq(4)
      expect(season_stats.teams.length).to eq(6)
      expect(season_stats.game_teams.length).to eq(8)
    end
  end

  describe '#worst_coach' do
    it 'returns the name of worst coach who has the wost win percentage for the season' do
      expect(season_stats.worst_coach(20122013)).to eq("John Tortorella")
    end
  end

  describe '#winningest_coach' do
    it 'returns the name of worst coach who has the wost win percentage for the season' do
      expect(season_stats.winningest_coach(20122013)).to eq("Claude Julien")
    end
  end

  describe '#calculate_win_percentage' do
    it 'returns hash where each coach is associated with their win percentage for the season' do
      expect(season_stats.calculate_win_percentage(20122013)).to eq({"Claude Julien"=>100.0, "Joel Quenneville"=>50.0, "John Tortorella"=>0.0, "Mike Babcock"=>50.0})
    end
  end

  describe '#calculate_accurate_shots_pct' do
    it "returns the hash where each team ID is associated with the accurate shots percentage" do
      expect(season_stats.calculate_accurate_shots_pct(20122013)).to eq({3=>23.53, 6=>30.0, 17=>25.0, 16=>20.0})
    end
  end

  describe '#most_accurate_team' do
    it 'returns the name of team with the best ratio of shots to goals for the season' do
      expect(season_stats.most_accurate_team(20122013)).to eq("FC Dallas")
    end
  end

  describe '#least_accurate_team' do
    it 'returns the name of team with the worst ratio of shots to goals for the season' do
      expect(season_stats.least_accurate_team(20122013)).to eq("New England Revolution")
    end
  end

  describe '#tackles_by_teams' do
    it 'returns the hash where each team ID is associated with the total tackles in the season' do
      expect(season_stats.tackles_by_teams(20122013)).to eq({3=>77, 6=>87, 17=>69, 16=>60})
    end
  end

  describe '#most_tackles' do
    it 'returns the name of team with the most tackles in the season' do
      expect(season_stats.most_tackles(20122013)).to eq("FC Dallas")
    end
  end

  describe '#fewest_tackles' do
    it 'returns the name of team with the most tackles in the season' do
      expect(season_stats.fewest_tackles(20122013)).to eq("New England Revolution")
    end
  end
end
