require './lib/stat_tracker'

describe StatTracker do
  
  let(:game_path){'./data/fixtures/games_i1.csv'}
  let(:team_path){'./data/fixtures/teams_i1.csv'}
  let(:game_teams_path){'./data/game_teams.csv'}
  

  let(:locations){{
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }}

  describe 'game' do
    
    it 'can pull in games csv data' do
      expect(StatTracker.games_csv(locations).length).to eq(19)
      expect(StatTracker.games_csv(locations)[0].game_id).to eq('2012030221')
      expect(StatTracker.games_csv(locations)[0].season).to eq('20122013')
      expect(StatTracker.games_csv(locations)[0].type).to eq('Postseason')
      expect(StatTracker.games_csv(locations)[0].date_time).to eq('5/16/13')
      expect(StatTracker.games_csv(locations)[0].away_team_id).to eq('3')
      expect(StatTracker.games_csv(locations)[0].home_team_id).to eq('6')
      expect(StatTracker.games_csv(locations)[0].away_goals).to eq('2')
      expect(StatTracker.games_csv(locations)[0].home_goals).to eq('3')
      expect(StatTracker.games_csv(locations)[0].venue).to eq('Toyota Stadium')
      expect(StatTracker.games_csv(locations)[0].venue_link).to eq('/api/v1/venues/null')
    end
  end

  describe 'team' do
    it 'can pull in teams csv data' do
      expect(StatTracker.teams_csv(locations).length).to eq(19)
      expect(StatTracker.teams_csv(locations)[0].team_id).to eq('1')
      expect(StatTracker.teams_csv(locations)[0].franchise_id).to eq('23')
      expect(StatTracker.teams_csv(locations)[0].team_name).to eq('Atlanta United')
      expect(StatTracker.teams_csv(locations)[0].abbreviation).to eq('ATL')
      expect(StatTracker.teams_csv(locations)[0].stadium).to eq('Mercedes-Benz Stadium')
      expect(StatTracker.teams_csv(locations)[0].link).to eq('/api/v1/teams/1')
    end
  end
end