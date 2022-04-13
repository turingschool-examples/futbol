require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      @stat_tracker = StatTracker.from_csv(@locations)

  end

    it 'exists and has attributes' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do
        expect(@stat_tracker.games.count).to eq(7441)
        expect(@stat_tracker.teams.count).to eq(32)
        expect(@stat_tracker.game_teams.count).to eq(14882)
    end

    it '#highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end



end
