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
        expect(@stat_tracker.count_of_teams).to be_an_instance_of(Integer)
      end
  end
end
# Game Statistics Tests


# League Statistics Tests


# Season Statistics Tests


# Team Statistics Tests
