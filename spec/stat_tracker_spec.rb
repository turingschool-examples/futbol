require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
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

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end


  describe '#Creates usable data' do
    it '#game_team_data_creation' do
      expect(@stat_tracker.game_team_data).to be_a Array
      expect(@stat_tracker.game_team_data[0]).to be_a Hash
    end

    it '#team_data_creation' do
      expect(@stat_tracker.team_data).to be_a Array
      expect(@stat_tracker.team_data[0]).to be_a Hash
    end
    
    it '#game_data_creation' do
      expect(@stat_tracker.game_data).to be_a Array
      expect(@stat_tracker.game_data[0]).to be_a Hash

    end

    it 'Highest Total Score' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'Lowest Total Score' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end
end
