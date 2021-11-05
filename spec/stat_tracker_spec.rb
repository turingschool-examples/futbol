require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './runner'

describe StatTracker do
  before(:each) do

    game_path = './data/games_tester.csv'
    team_path = './data/teams_tester.csv'
    game_teams_path = './data/game_teams_tester.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end


    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end

    describe '#count of teams' do

      it 'returns total number of teams' do
        expect(@stat_tracker.count_of_teams).to eq(10)
      end

      it 'returns an integer' do
        expect(@stat_tracker.count_of_teams).to be_instance_of(Integer)
      end
  end

  describe '#best_offense' do
    it 'returns team with most avg goals per game for all seasons' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.best_offense).to be_instance_of(String)
    end
  end

  describe '#games_by_team' do
    it 'returns number of games per team by team_id' do
      expect(@stat_tracker.games_by_team(3).length).to eq(5)
    end
  end

  describe '#total goals_by_team' do
    it 'returns number of total goals by team_id' do
      expect(@stat_tracker.total_goals_by_team(3)).to eq(8)
    end
  end

  describe '#average_goals_per_game' do
    it 'returns number of average goals per game by team_id' do
      expect(@stat_tracker.average_goals_per_game(3)).to eq(1.6)
    end
  end
end
