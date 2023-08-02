require 'spec_helper'

RSpec.describe StatTracker do
  let(:game_path) {'./data/data_games.csv'}
  let(:team_path) {'./data/data_teams.csv'}
  let(:game_teams_path) {'./data/data_game_teams.csv'}
  let(:locations) {{
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }}
  let(:stat_tracker) { StatTracker.from_csv(locations) }

  describe "#initialize" do 
    it "exists" do 

      expect(stat_tracker).to be_a StatTracker
    end
  end
end