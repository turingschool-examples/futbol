require 'csv'
require 'spec_helper.rb'

RSpec.describe StatTracker do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
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

    it "exists as gameteam objects now" do 
      expect(stat_tracker.game_teams[0..77]).to all(be_an_instance_of(GameTeam))
    end

    # it "has certain types of attributes" do 
    #   expect(stat_t)
    # end
  end
end 
