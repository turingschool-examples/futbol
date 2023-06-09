require 'spec_helper.rb'

RSpec.describe StatTracker do
  before do
    games_test_csv = './spec/feature/game_test.csv'
    game_teams_test_csv = './spec/feature/game_team_test.csv'
    team_test_csv = './spec/feature/team_test.csv'

    @locations = {
      games: games_test_csv,
      teams: team_test_csv,
      game_by_team: game_teams_test_csv
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

    it "creates team objects" do
      expect(@stat_tracker.teams[0]).to be_a(Team)
      expect(@stat_tracker.teams.count).to eq(32)
      expect(@stat_tracker.teams)

    end
  end

  describe "#game_statics" do

    it "#highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end

    it "#lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end

    it "#percentage_home_wins" do
      expect(@stat_tracker.percentage_home_wins).to eq(12.48)
    end

    it "#percentage_visitor_wins" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(22.68)
    end

    it "#average_goals_per_game" do
      expect(@stat_tracker.average_goals_per_game).to eq(3.72)
    end

    it "#percentage_ties" do
      expect(@stat_tracker.percentage_ties).to eq(17.31)
    end

    it "#count_of_games_by_season" do
    expected = {
      "20122013" => 20,
      "20132014" => 25,
      "20142015" => 2,
      "20162017" => 5
    }
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end

  describe '#league_statics' do
    it '#count_of_teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it '#winningest_coach' do

      expect(@stat_tracker.winningest_coach).to eq("Claude Julien")
    end

    it '#worst_coach' do
      expect(@stat_tracker.worst_coach).to eq("Glen Gulutzan")
      
    it "can find the average goals per season" do
      expect(@stat_tracker.average_goals_by_season).to eq({
        "20122013"=>3.9,
        "20132014"=>3.64,
        "20142015"=>5.0,
        "20162017"=>2.8
      })
    end

    it "#average_goals_by_team" do
    expected = {
      "3"=>1.8064516129032258,
      "6"=>2.727272727272727,
      "5"=>1.9,
      "17"=>1.9285714285714286,
      "16"=>2.1379310344827585,
      "9"=>2.1818181818181817,
      "8"=>1.7272727272727273,
      "30"=>1.875,
      "26"=>2.130434782608696,
      "19"=>1.6666666666666667,
      "24"=>2.3529411764705883,
      "2"=>1.8333333333333333,
      "15"=>1.6923076923076923,
      "20"=>1.75,
      "14"=>1.9230769230769231,
      "28"=>2.4,
      "4"=>1.0,
      "21"=>1.7142857142857142,
      "25"=>2.5
    }
    expect(@stat_tracker.average_goals_by_team).to eq(expected)
    end

    it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end

    it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq("Chicago Fire")
    end

    it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Seattle Sounders FC")
    end

    it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Chicago Fire")
  end

    it "#highest_scoring_visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("Los Angeles FC")
    end

    it "#highest_scoring_home_team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Seattle Sounders FC")
  end
end

  describe "#season_statistics" do
    it "#most_tackles" do
      expect(@stat_tracker.most_tackles).to eq("Houston Dynamo")
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles).to eq("Toronto FC")
    end

    it "#total_goals_by_teams" do
      expect(@stat_tracker.total_goals_by_teams).to eq({
        "3"=>56,
        "6"=>30,
        "5"=>38,
        "17"=>27,
        "16"=>62,
        "9"=>24,
        "8"=>19,
        "30"=>45,
        "26"=>49,
        "19"=>30,
        "24"=>40,
        "2"=>11,
        "15"=>22,
        "20"=>7,
        "14"=>25,
        "28"=>12,
        "4"=>6,
        "21"=>12,
        "25"=>15
      })
    end

    it "#most_accurate_team)" do
      expect(@stat_tracker.most_accurate_team).to eq("Chicago Fire")
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team).to eq("Chicago Red Stars")
    end

    it 'checks winningest coach' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end

    it 'checks winningest coach' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
    end
  end
end