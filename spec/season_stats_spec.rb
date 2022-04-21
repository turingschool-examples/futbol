require './lib/season_stats'
require './lib/stat_tracker'
require './lib/csv_reader'

RSpec.describe SeasonStats do
  before :each do
      @game_path = './data/dummy_games.csv'
      @team_path = './data/teams.csv'
      @game_teams_path = './data/dummy_game_teams.csv'

      @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }

      @season_stats = SeasonStats.new(@locations)
  end

    it 'exists' do 
      expect(@season_stats).to be_a(SeasonStats)
    end

    it "#winningest_coach can produce the name of the coach" do
      expect(@season_stats.winningest_coach("2012030221")).to eq("Claude Julien")
    end

    it "returns loser head coach" do
      expect(@season_stats.worst_coach("2012030221")).to eq("Gerard Gallant")
    end

    it "#most_accurate_team returns team with best ratio of shots to goals" do
      expect(@season_stats.most_accurate_team("20122013")).to eq("DC United")
    end

    it "#least_accurate_team can produce the team with worst ratio of shots to goals" do
      expect(@season_stats.least_accurate_team("20122013")).to eq("Houston Dynamo")
    end

    it "#most_tackles returns name of the team with most tackles per season" do
      expect(@season_stats.most_tackles("2012030221")).to be_a(String)
    end

    it "#fewest_tackles returns the team with the least amount of tackles" do
      expect(@season_stats.fewest_tackles("2012030221")).to be_a(String)
    end
end
