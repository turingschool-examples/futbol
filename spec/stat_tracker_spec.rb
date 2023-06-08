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
      expect(@stat_tracker.games.count).to eq(5)

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

  describe '#game_statics' do
    
    it "#highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end

    it "#lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq(3)
    end

    it "can find the percentage of home wins" do
      expect(@stat_tracker.percentage_home_wins).to eq(0.1)
    end

    it 'can calculate #percentage_ties' do
      expect(@stat_tracker.percentage_ties).to eq(20.0)
    end

    it 'can calculate #count_of_games_by_season' do
    expected = {"20122013" => 5}
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end
end