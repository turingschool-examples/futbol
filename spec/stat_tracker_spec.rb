require './lib/stat_tracker'

RSpec.describe StatTracker do
  context 'Iteration 1' do
    before :each do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams_dummy.csv'
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
      expect(@stat_tracker.games).to all(be_an(Game))
      expect(@stat_tracker.teams.values).to all(be_an(Team))
      expect(@stat_tracker.seasons.values).to all(be_an(Season))
    end

    it 'can return average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.85)
    end

    it 'can return percentage of home wins as decimal' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.5)
    end

    it 'can return percentage visitor wins as decimal' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.45)
    end
  end
end
