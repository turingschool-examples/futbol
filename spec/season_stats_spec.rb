require "csv"
require "./lib/season_stats"
require "pry"
require "./lib/stat_tracker"

RSpec.describe SeasonStats do
  before :each do
    @game_path = "./data/games.csv"
    @team_path = "./data/teams.csv"
    @game_teams_path = "./data/game_teams.csv"
    @games_fixture_path = "./data/games_fixture.csv"
    @games_teams_fixture_path = "./data/games_teams_fixture.csv"
    @locations =
      {
        games: @games_fixture_path,
        teams: @team_path,
        game_teams: @game_teams_path,
        games_fixture_path: @games_fixture_path,
        games_teams_fixture_path: @games_teams_fixture_path

      }
    @season_stats = SeasonStats.new(@locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@season_stats).to be_an_instance_of SeasonStats
    end
  end

  describe "#winningest_coach" do
    xit "can name the coach with the best win percentage of the season" do
      expect(@season_stats.winningest_coach).to eq
    end
  end

  describe "#worst_coach" do
    xit "can name the coach with the worst percentage for the season" do
      expect(@season_stats.worst_coach).to eq
    end
  end

  describe "#most_accurate_team" do
    xit "can name the team with the best raiot of shots to goals for the season" do
      expect(@season_stats.most_accurate_team).to eq
    end
  end

  describe "#least_accurate_team" do
    xit "can name the team with the worst ratio of shots to goals for the season" do
      expect(@season_stats.least_accurate_team).to eq
    end
  end

  describe "#most_tackles" do
    xit "can name the team with the most tackles in the season" do
      expect(@season_stats.most_tackles).to eq
    end
  end

  describe "#fewest_tackles" do
    xit "can name the team with the fewest tackles in the season" do
      expect(@season_stats.fewest_tackles).to eq
    end
  end
end
