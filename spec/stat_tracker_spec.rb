require './lib/stat_tracker'

RSpec.describe StatTracker do
  context 'Iteration 1' do
    before :each do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(locations)
    end

    it 'exists' do

      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has data' do

      expect(@stat_tracker.games).to be_an_instance_of(CSV::Table)
      expect(@stat_tracker.teams).to be_an_instance_of(CSV::Table)
      expect(@stat_tracker.game_teams).to be_an_instance_of(CSV::Table)
    end

    it 'show highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end
end
