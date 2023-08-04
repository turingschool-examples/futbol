require_relative 'spec_helper'

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
      expect(stat_tracker.highest_total_score).to eq(11)
    end

    it "#lowest_total_score" do 
    # require 'pry';binding.pry
      expect(stat_tracker.lowest_total_score).to be_a(Integer)
      expect(stat_tracker.lowest_total_score).to eq(0)
    end

    it "#total_games" do
      expect(stat_tracker.total_games).to be_a(Float)
      expect(stat_tracker.total_games).to eq(7441)
    end

    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to be_a(Float)
      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end
    
    it "#percentage_visitor_wins" do
      expect(stat_tracker.percentage_visitor_wins).to be_a(Float)
      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it "#percentage_ties" do
      expect(stat_tracker.percentage_ties).to be_a(Float)
      expect(stat_tracker.percentage_ties).to eq(0.2)
    end
        
    it "#average_goals_per_game" do
      expect(stat_tracker.average_goals_per_game).to be_a(Float)
    end

    it "#count_of_games_by_season" do
      expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
      expect(stat_tracker.count_of_games_by_season.keys[0]).to be_a(String)
      expect(stat_tracker.count_of_games_by_season.values[0]).to be_a(Integer)
    end 

    it "#total_goals_by_season" do 
      expect(stat_tracker.total_goals_by_season).to be_a Hash

      expected = {
        "20122013"=>3322.0,
        "20162017"=>5565.0,
        "20142015"=>5461.0,
        "20152016"=>5499.0,
        "20132014"=>5547.0,
        "20172018"=>6019.0
      }
    
      expect(stat_tracker.total_goals_by_season).to eq(expected)
    end

    it "#average_goals_by_season" do
      expect(stat_tracker.average_goals_by_season).to be_a(Hash)
      
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      
      expect(stat_tracker.average_goals_by_season).to eq(expected)

    end
  end

  describe "League Statistics" do
    it "#count_of_teams" do
      expect(stat_tracker.count_of_teams).to be_a(Integer)
    end

    it "#best_offense" do
      expect(stat_tracker.best_offense).to be_a(String)
    end
    
    it "#worst_offense" do
      expect(stat_tracker.worst_offense).to be_a(String)
    end

    it "#total_home_goals" do
      expect(stat_tracker.total_home_goals).to be_a(Hash)
    end

    it "#highest_scoring_home_team" do
      expect(stat_tracker.highest_scoring_home_team).to be_a(String)
      expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it "#lowest_scoring_home_team" do
      expect(stat_tracker.lowest_scoring_home_team).to be_a(String)
      expect(stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end

    it "#highest_scoring_visitor" do 
    # require 'pry';binding.pry
      expect(stat_tracker.highest_scoring_visitor).to be_a(String)
      expect(stat_tracker.highest_scoring_visitor).to eq( "FC Dallas")
    end

    it "#lowest_scoring_visitor" do 
      expect(stat_tracker.lowest_scoring_visitor).to be_a(String)
      expect(stat_tracker.lowest_scoring_visitor).to eq( "San Jose Earthquakes")
    end
end