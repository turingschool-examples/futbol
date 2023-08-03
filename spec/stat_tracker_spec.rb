require 'spec_helper'

RSpec.describe StatTracker do
  # let(:game_path) {'./data/data_games.csv'}
  # let(:team_path) {'./data/data_teams.csv'}
  # let(:game_teams_path) {'./data/data_game_teams.csv'}
  # let(:locations) {{
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }}

  let(:game_path) {'./data/games.csv'}
  let(:team_path) {'./data/teams.csv'}
  let(:game_teams_path) {'./data/game_teams.csv'}
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

  describe "Game Statistics" do 
    it "#highest_total_score" do 
    # require 'pry';binding.pry
      expect(stat_tracker.highest_total_score).to be_a(Integer)
    end

    it "#lowest_total_score" do 
    # require 'pry';binding.pry
      expect(stat_tracker.lowest_total_score).to be_a(Integer)
    end

    it "#total_games" do
      expect(stat_tracker.total_games).to be_a(Float)
      expect(stat_tracker.total_games).to eq(7441)
    end

    xit "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to be_a(Float)
    end
  end
end