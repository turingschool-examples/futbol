require './lib/stat_tracker'

describe StatTracker do
  
  let(:game_path){'./data/fixtures/games_i1.csv'}
  let(:team_path){'./data/fixtures/teams_i1.csv'}
  let(:game_teams_path){'./data/fixtures/game_teams_i1.csv'}
  

  let(:locations){{
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }}


  it 'can pull in new data from files' do
    expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
  end

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

  describe 'game_team' do
    it 'can pull in game_teams csv data' do
      expect(StatTracker.game_teams_csv(locations).length).to eq(19) 
      expect(StatTracker.game_teams_csv(locations)[0].game_id).to eq('2012030221')
      expect(StatTracker.game_teams_csv(locations)[0].team_id).to eq('3')
      expect(StatTracker.game_teams_csv(locations)[0].hoa).to eq('away')
      expect(StatTracker.game_teams_csv(locations)[0].result).to eq('LOSS')
      expect(StatTracker.game_teams_csv(locations)[0].settled_in).to eq('OT')
      expect(StatTracker.game_teams_csv(locations)[0].head_coach).to eq('John Tortorella')
      expect(StatTracker.game_teams_csv(locations)[0].goals).to eq('2')
      expect(StatTracker.game_teams_csv(locations)[0].shots).to eq('8')
      expect(StatTracker.game_teams_csv(locations)[0].tackles).to eq('44')
      expect(StatTracker.game_teams_csv(locations)[0].pim).to eq('8')
      expect(StatTracker.game_teams_csv(locations)[0].power_play_opportunities).to eq('3')
      expect(StatTracker.game_teams_csv(locations)[0].power_play_goals).to eq('0')
      expect(StatTracker.game_teams_csv(locations)[0].face_off_win_percentage).to eq('44.8')
      expect(StatTracker.game_teams_csv(locations)[0].giveaways).to eq('17')
      expect(StatTracker.game_teams_csv(locations)[0].takeaways).to eq('7')
    end
  end

  describe 'game statistics' do
    let(:stat_tracker) {StatTracker.from_csv(locations)}

    it "can determine #average_goals_per_game" do
      expect(stat_tracker.average_goals_per_game).to eq(3.68)
    end

    it "can determine #average_goals_by_season" do
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      expect(stat_tracker.average_goals_by_season).to eq(expected)
    end

  end


  
end