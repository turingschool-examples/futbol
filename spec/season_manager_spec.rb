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
      expect(@stat_tracker.season_manager.most_accurate_team("20122013", @stat_tracker.team_manager.teams_by_id)).to eq("John Tortorella")
    end
  end

  describe '#least_accurate_team' do
    it "can return the least least_accurate_team according to shots on goal" do
      expect(@stat_tracker.season_manager.least_accurate_team("20122013", @stat_tracker.team_manager.teams_by_id)).to eq("John Tortorella")
    end
  end
end
