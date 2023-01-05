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
    let(:game_path_2){'./data/fixtures/games_i2.csv'}
    #note that we will need to edit team/game_team paths if new fixture data is created for use in these tests
    
    let(:locations_2){{
      games: game_path_2,
      teams: team_path,
      game_teams: game_teams_path
    }}

    let(:stat_tracker) {StatTracker.from_csv(locations_2)}


    it "can determine #average_goals_per_game" do
      expect(stat_tracker.average_goals_per_game).to eq(4.45)
    end


    it 'can determine #count_of_games_by_season' do
      expected = {
        "20122013"=>7,
        "20132014"=>10,
        "20142015"=>2,
        "20152016"=>9,
        "20162017"=>9,
        "20172018"=>12
      }
      expect(stat_tracker.count_of_games_by_season).to eq expected
    end

    it "can determine #average_goals_by_season" do
      expected = {
        "20122013"=>5,
        "20132014"=>4.8,
        "20142015"=>4.5,
        "20152016"=>3.78,
        "20162017"=>4.44,
        "20172018"=>4.33
      }
      expect(stat_tracker.average_goals_by_season).to eq(expected)
    end


    it "can determine #home_wins" do
      expect(stat_tracker.home_wins).to eq(20)
    end

    it "can determine #away_wins" do
      expect(stat_tracker.away_wins).to eq(23)
    end

    it "can determine #tie_games" do
      expect(stat_tracker.tie_games).to eq(6)
    end

    it "can determine #percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq(40.82)
    end

    it "can determine #percentage_visitor_wins" do
      expect(stat_tracker.percentage_visitor_wins).to eq(46.94)
    end

    it "can determine #percentage_ties" do
      expect(stat_tracker.percentage_ties).to eq(12.24)
    end
    
    it "can determine highest_total_score" do
      expect(stat_tracker.highest_total_score).to eq(8)
    end

    it "can determine lowest_total_score" do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe 'league statistics' do
    let(:game_path_2){'./data/fixtures/games_i2.csv'}
    #note that we will need to edit team/game_team paths if new fixture data is created for use in these tests
    
    let(:locations_2){{
      games: game_path_2,
      teams: team_path,
      game_teams: game_teams_path
    }}

    let(:stat_tracker) {StatTracker.from_csv(locations_2)}

    it 'can count the number of teams' do
      expect(stat_tracker.count_of_teams).to eq(19)
    end
    
    it 'can calculate the lowest_scoring_visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq("FC Cincinnati, Sporting Kansas City, New York Red Bulls")
    end

    it 'can calculate the highest_scoring_visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq("Chicago Fire")
    end

    it 'can produce an array_of_gameids by season' do
      expect(stat_tracker.array_of_gameids_by_season("20122013")).to be_an(Array)
      expect(stat_tracker.array_of_gameids_by_season("20122013")[0]).to be_a(String)
      expect(stat_tracker.array_of_gameids_by_season("20122013")[0].length).to eq(10)
    end

    it 'can produce an array_of_game_teams by season' do
      expect(stat_tracker.array_of_game_teams_by_season("20122013")).to be_an(Array)
      expect(stat_tracker.array_of_game_teams_by_season("20122013")[0]).to be_a(StatTracker::GameTeam)
    end

    it 'can calculate win percentages for coaches and organize them' do
      expect(stat_tracker.coaches_win_percentages_hash("20122013")).to be_a(Hash)
      expect(stat_tracker.coaches_win_percentages_hash("20122013").first[1]).to be_a(Float)
    end
  end
  
end