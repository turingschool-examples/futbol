require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

    it 'exists and has attributes' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do
        expect(@stat_tracker.games.count).to eq(20)
        expect(@stat_tracker.teams.count).to eq(32)
        expect(@stat_tracker.game_teams.count).to eq(40)
    end


  
