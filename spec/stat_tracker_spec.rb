require 'spec_helper'

RSpec.describe StatTracker do
  let(:game_path) {'./data/games.csv'}
  let(:team_path) {'./data/teams.csv'}
  let(:game_teams_path) {'./data/game_teams.csv'}
  let(:files) {{
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }}
  let(:stat_tracker) { StatTracker.new(files) }

  describe "#initialize" do 
    it "exists" do 

      expect(stat_tracker).to be_a StatTracker
    end
  end
end