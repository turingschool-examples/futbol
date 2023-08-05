require "spec_helper"

RSpec.describe SeasonStatistics do

  before(:each) do
    @game_path = './fixture/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_fixture.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    
    @season_statistics = SeasonStatistics.new(@locations)
  end
  describe "#initialize" do
    it "exists" do
      expect(@season_statistics).to be_a(SeasonStatistics)
    end
  end

  describe "#locations" do
    it "returns the location attribute" do
      expect(@season_statistics.locations).to eq(@locations)
    end
  end

  describe "#game_data" do
    it "returns game_data" do
      expect(@season_statistics.game_data).to be_a(CSV::Table)
    end
  end

  describe "#teams_data" do
    it "returns teams_data" do
      expect(@season_statistics.teams_data).to be_a(CSV::Table)
    end
  end

  describe "#game_team_data" do
    it "returns game_team_data" do
      expect(@season_statistics.game_team_data).to be_a(CSV::Table)
    end
  end

  describe "#winningest_coach" do
    it "returns coach with best win percentage for season" do
      expect(@season_statistics.winningest_coach("20122013")).to eq("Claude Julien")
    end
  end

  describe "#worst_coach" do
    it "returns coach with worse win percentage for season" do
      expect(@season_statistics.worst_coach("20122013")).to eq("John Tortorella")
    end
  end

  describe "#most_accurate_team" do
    it "returns the team with the best ratio of shots to goals for the season" do
      expect(@season_statistics.most_accurate_team("20122013")).to eq("FC Dallas")
    end
  end
  
  describe "#least_accurate_team" do
    it "returns the team with the worst ratio of shots to goals for the season" do
      expect(@season_statistics.least_accurate_team("20122013")).to eq("Sporting Kansas City")
    end
  end
  
  describe "#most_tackles" do
    it "returns name of the team with the most tackles in the season" do
      expect(@season_statistics.most_tackles("20122013")).to eq("FC Dallas")
    end
  end
  
  describe "#fewest_tackles" do
    it "returns name of the team with the least tackles in the season" do
      expect(@season_statistics.fewest_tackles("20122013")).to eq("LA Galaxy")
    end
  end

  describe "#find_season_games" do
    it "finds games based on given season id" do
      expect(@season_statistics.find_season_games("20122013").count).to eq(19)
    end
  end

  describe "#find_season_game_teams" do
    it "finds game_team entries based off of given array of season games" do
      season_games = @season_statistics.find_season_games("20122013")

      expect(@season_statistics.find_season_game_teams(season_games).count).to eq(19)
      expect(@season_statistics.find_season_game_teams(season_games)).to be_a(Array)
    end
  end

  describe "#get_coach_name" do
    it "finds coach name based off of team id" do
      expect(@season_statistics.get_coach_name(["6", 9])).to eq("Claude Julien")
    end
  end

  describe "#get_team_name" do
    it "finds team name based off of team id" do
      expect(@season_statistics.get_team_name(["6", 24.0])).to eq("FC Dallas")
    end
  end
end