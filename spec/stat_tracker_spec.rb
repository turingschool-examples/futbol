require 'spec_helper.rb'

RSpec.describe StatTracker do
  before do
    games_test_csv = './spec/feature/game_test.csv'
    game_teams_test_csv = './spec/feature/game_team_test.csv'
    team_test_csv = './spec/feature/team_test.csv'
    games_csv = './data/games.csv'
    team_csv = './data/teams.csv'
    game_teams_csv = './data/game_teams.csv'

    @locations = {
      games: games_test_csv,
      teams: team_test_csv,
      game_by_team: game_teams_test_csv
    }
    @locations_2 = {
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
      expect(@stat_tracker.games.count).to eq(52)

    end

    it 'creates team_games objects' do

      expect(@stat_tracker.game_by_team[0]).to be_a(Game_By_Team)
      expect(@stat_tracker.game_by_team.count).to eq(269)
      expect(@stat_tracker.game_by_team)

    end

    it 'creates team objects' do
      expect(@stat_tracker.teams[0]).to be_a(Team)
      expect(@stat_tracker.teams.count).to eq(32)
      expect(@stat_tracker.teams)

    end
  end

  describe '#game_statics' do
    
    it "#highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end

    it "#lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end

    it "can find the percentage of home wins" do
      expect(@stat_tracker.percentage_home_wins).to eq(12.48)
    end

    it 'can find the percentage of away wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(22.68)
    end
    
    it 'can find average goals per game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.72)
    end
    it 'can calculate #percentage_ties' do
      expect(@stat_tracker.percentage_ties).to eq(17.31)
    end

    it 'can calculate #count_of_games_by_season' do
    expected = {
      "20122013" => 20,
      "20132014" => 25,
      "20142015" => 2,
      "20162017" => 5
      }
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#league_statics' do

    it 'can calculate #highest_scoring_visitor' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("Los Angeles FC")
    end

    it 'can calculate #highest_scoring_home_team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Seattle Sounders FC")
    end
  end
end