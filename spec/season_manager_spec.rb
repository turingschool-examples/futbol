require './lib/season_manager'
require './lib/stat_tracker'
require './lib/game_manager'

RSpec.describe SeasonManager do
  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.new(@file_paths)
  end

  it "is a thing" do
    expect(@stat_tracker.season_manager).to be_a(SeasonManager)
    expect(@stat_tracker.season_manager.seasons_hash).to be_a(Hash)
  end

  describe '#winningest_coach' do
    it "can return all the coaches and their win percentages" do
      expect(@stat_tracker.season_manager.winningest_coach("20122013")).to eq("Claude Julien")
    end
  end

  describe '#worst_coach' do
    it "can return all the coaches and their win percentages" do
      expect(@stat_tracker.season_manager.worst_coach("20122013")).to eq("John Tortorella")
    end
  end

  describe '#most_accurate_team' do
    it "can return the most most_accurate_team according to shots on goal" do
      expect(@stat_tracker.season_manager.most_accurate_team("20122013")).to eq("9")
    end
  end

  describe '#least_accurate_team' do
    it "can return the least least_accurate_team according to shots on goal" do
      expect(@stat_tracker.season_manager.least_accurate_team("20122013")).to eq("5")
    end
  end

  describe '#most_tackles' do
    it "can return the name of the team witht he most tackles" do
      expect(@stat_tracker.season_manager.most_tackles("20122013")).to eq('17')
    end
  end

  describe '#fewest_tackles' do
    it "can return the name of the team with the least tackles" do
      expect(@stat_tracker.season_manager.fewest_tackles("20122013")).to eq("5")
    end
  end

  describe '#best_season' do
    it "can return the best season for a team by highest win percentage" do
      expect(@stat_tracker.season_manager.best_season("6")).to eq("20122013")
    end
  end

  describe '#worst_season' do
    it "can return the best season for a team by highest win percentage" do
      expect(@stat_tracker.season_manager.worst_season("6")).to eq("20122013")
    end
  end
end
