require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    @stat_tracker1 =StatTracker.new
  end
  describe "initialize" do
    it "exists" do
      expect(@stat_tracker1).to be_a(StatTracker)
      expect(@stat_tracker1.read_csv(@locations)).to be_a(StatTracker)
    end
  end

end
