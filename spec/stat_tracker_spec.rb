require 'spec_helper.rb'

RSpec.describe StatTracker do
  before do
    @stat_tracker = StatTracker.new
  end
  describe "#exists" do
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it "has readable attributes" do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.teams).to be_a(Array)
      expect(@stat_tracker.game_teams).to be_a(Array)
    end
  end



  describe "#from_csv" do
    it "creates game objects" do


      @stat_tracker.from_csv(@locations)
      expect(@stat_tracker.games[0]).to be_a(Game)
      expect(@stat_tracker.games)
      expect(@stat_tracker.games.count).to eq(7441)
      expect(@stat_tracker.game_teams.count).to eq(14822)
      expect(@stat_tracker.teams.count).to eq(32)

    end
  end
end