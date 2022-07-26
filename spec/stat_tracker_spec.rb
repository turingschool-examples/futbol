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

    it 'can return the number average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.78)
    end

  end
end
