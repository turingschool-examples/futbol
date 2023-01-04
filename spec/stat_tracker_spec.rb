require 'csv'
require 'spec_helper.rb'

RSpec.describe StatTracker do
  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  describe "#initialize" do
    it "exists" do 
      expect(stat_tracker).to be_instance_of(StatTracker)
    end

  describe "#attributes" do 
    it "has attributes of various arrays" do 
      expect(stat_tracker.game_teams).to be_an_instance_of(Array)
      expect(stat_tracker.games).to be_an_instance_of(Array)
      expect(stat_tracker.teams).to be_an_instance_of(Array)
    end

  it "all of the objects in the respective arrays are of one specific object type consistent with the array" do 
    expect(stat_tracker.game_teams[0..14882]).to all(be_an_instance_of(GameTeam))
    expect(stat_tracker.games[0..7441]).to all(be_an_instance_of(Game))
    expect(stat_tracker.teams[0..32]).to all(be_an_instance_of(Team))
  end 

  it "the objects all have the correct attributes" do 

    expect(stat_tracker.game_teams[0..14882].sample).to have_attributes(:game_id => Integer)
    expect(stat_tracker.games[0..7441].sample).to have_attributes(:venue => String)
    expect(stat_tracker.teams[0..32].sample).to have_attributes(:stadium => String)

  end 
  
  end 
  end
end