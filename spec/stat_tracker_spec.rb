require 'spec_helper.rb'

RSpec.describe StatTracker do
  before do
    games_csv = './spec/feature/game_test.csv'
    game_teams_csv = './spec/feature/game_team_test.csv'
    team_csv = './spec/feature/team_test.csv'
    @locations = {
      games: games_csv,
      teams: team_csv,
      game_by_team: game_teams_csv
    }
    @stat_tracker = StatTracker.new
    @stat_tracker.from_csv(@locations)
  end
  describe "#exists" do
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it "has readable attributes" do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.teams).to be_a(Array)
      expect(@stat_tracker.game_by_team).to be_a(Array)
      
    end
  end

  describe "#from_csv" do
    it "creates game objects" do
      
      expect(@stat_tracker.games[0]).to be_a(Game)
      expect(@stat_tracker.games.count).to eq(4)
      expect(@stat_tracker.games)

    end

    it 'creates team_games objects' do

      expect(@stat_tracker.game_by_team[0]).to be_a(Game_By_Team)
      expect(@stat_tracker.game_by_team.count).to eq(4)
      expect(@stat_tracker.game_by_team)

    end

    it 'creates team objects' do
      expect(@stat_tracker.teams[0]).to be_a(Team)
      expect(@stat_tracker.teams.count).to eq(4)
      expect(@stat_tracker.teams)

    end
  end
end