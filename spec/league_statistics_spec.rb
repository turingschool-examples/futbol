RSpec.describe LeagueStatistics do
  context 'when a league statistics is created' do
    mock_games_data = './data/mock_games.csv' 
    team_data = './data/teams.csv' 
    mock_game_teams_data = './data/mock_game_teams.csv' 
    
    let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}
  
    let!(:stat_tracker) { StatTracker.from_csv(mock_locations) }

    let!(:league_statistics) { LeagueStatistics.new {extend Leagueable, TeamNameable}}
    
    it 'instantiates' do
      expect(league_statistics).to be_a(LeagueStatistics)
    end

    it '#count_of_teams' do
      expect(league_statistics.count_of_teams).to eq 32
    end

    it '#best_offense' do
      expect(league_statistics.best_offense).to eq 'Columbus Crew SC'
    end

    it '#worst_offense' do
      expect(league_statistics.worst_offense).to eq 'Houston Dynamo'
    end

    it '#highest_scoring_visitor' do
      expect(league_statistics.highest_scoring_visitor).to eq 'Columbus Crew SC'
    end

    it '#highest_scoring_home_team' do
      expect(league_statistics.highest_scoring_home_team).to eq 'Chicago Red Stars'
    end

    it '#lowest_scoring_visitor' do
      expect(league_statistics.lowest_scoring_visitor).to eq 'Philadelphia Union'
    end

    it '#lowest_scoring_home_team' do
      expect(league_statistics.lowest_scoring_home_team).to eq 'Chicago Fire'
    end
  end
end