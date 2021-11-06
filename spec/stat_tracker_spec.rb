require 'csv'
require './lib/stat_tracker'
require './lib/game_team'
require './lib/game'
require './lib/team'
require './runner'

describe StatTracker do
  before(:each) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

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
# Game Statistics Test



# League Statistics Tests

  describe '#winningest_coach' do
    it 'returns a string'do
      expect(@stat_tracker.winningest_coach(20122013)).to be_a(String)
    end

    it 'gives name of Coach with best win percentage of season' do
      expect(@stat_tracker.winningest_coach(20122013)).to eq("Claude Julien")
    end
  end
end
# Season Statistics Tests


# Team Statistics Tests
