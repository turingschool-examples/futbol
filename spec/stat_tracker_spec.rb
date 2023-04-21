require 'spec_helper'

RSpec.describe StatTracker do
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

  describe "initialize" do 
    it "exists" do 
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  describe "#games.csv" do
    it "can create an object from StatTracker" do  
      expect(@stat_tracker.games[0].game_id).to eq(2012030221)
      expect(@stat_tracker.games).to be_an(Array)
      expect(@stat_tracker.games.sample).to be_a(Game)
      expect(@stat_tracker.games).to all(be_a(Game))
    end
  end

  describe "#game_teams.csv" do
    it "can create an object from StatTracker" do  
      expect(@stat_tracker.game_teams[0].game_id).to eq("2012030221")
      expect(@stat_tracker.game_teams).to be_an(Array)
      expect(@stat_tracker.game_teams.sample).to be_a(GameTeams)
      expect(@stat_tracker.game_teams).to all(be_a(GameTeams))
    end
  end

end