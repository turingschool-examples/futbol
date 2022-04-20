require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

    it 'exists and has attributes' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do
        expect(@stat_tracker.games.count).to eq(20)
        expect(@stat_tracker.teams.count).to eq(32)
        expect(@stat_tracker.game_teams.count).to eq(40)
    end

    describe 'Season Statistics' do

      it "organizes seasons by year" do

        expect(@stat_tracker.games_by_season("2012030221").length).to eq(1612)
        expect(@stat_tracker.games_by_season("2012030221")).to be_a(Array)
      end

      it "organizes a specific season by team" do

        expect(@stat_tracker.organize_teams("2012030221").length).to eq(30)
        expect(@stat_tracker.organize_teams("2013020177").length).to eq(30)

      end

      it "calculates the winning percentage per team per season" do

        expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["1"]).to eq(0.33)
        expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["10"]).to eq(0.44)
        expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["17"]).to eq(0.47)
        expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["3"]).to eq(0.37)

      end

      it "returns head coach given team_id" do

        expect(@stat_tracker.head_coach_name("3")).to eq(("John Tortorella"))

      end

      it "returns winningest head coach" do

        expect(@stat_tracker.winningest_coach("2012030221")).to eq(("Claude Julien"))

      end

      it "returns loser head coach" do

        expect(@stat_tracker.worst_coach("2012030221")).to eq(("Gerard Gallant"))

      end

      it "returns calculates the shooting percentage per team per season" do


        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["3"]).to eq(0.25)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["8"]).to eq(0.29)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["26"]).to eq(0.3)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["30"]).to eq(0.28)
      end

      it "defines team name by team_id" do

        expect(@stat_tracker.team_name("3")).to eq(("Houston Dynamo"))
      end

      it "returns most accurate team" do


        expect(@stat_tracker.most_accurate_team("2012030221")).to eq(("DC United"))
      end

      it "returns least accurate team" do

        expect(@stat_tracker.least_accurate_team("2012030221")).to eq(("Houston Dynamo"))

      end

      it "returns the total number of tackles per team in a season" do

        expect(@stat_tracker.total_tackles_by_season("2012030221")).to be_a(Hash)

      end

      it "returns the team with the most tackles" do

        expect(@stat_tracker.most_tackles("2012030221")).to be_a(String)
      end

      it "returns the team with the least amount of tackles" do

        expect(@stat_tracker.least_tackles("2012030221")).to be_a(String)
      end
    end
    describe "Game statistics" do
      it "can tell us the highest scoring game" do
        expect(@stat_tracker.highest_total_score).to eq(6)
      end
      
      it "can tell us the lowest scoring game" do
        expect(@stat_tracker.lowest_total_score).to eq(1)
      end

      it "can tell us the percentage of home games won" do
        expect(@stat_tracker.percentage_home_wins).to eq(0.5)
      end

      it "can tell us the percentage of away games won" do
        expect(@stat_tracker.percentage_visitor_wins).to eq(0.35)
      end

      it "can tell us the percentage of ties" do
        expect(@stat_tracker.percentage_ties).to eq(0.15)
      end

      it "can tell us the average goals per game" do
        expect(@stat_tracker.average_goals_per_game).to eq(4.15)
      end

      it "can tell us the average goals per season" do
        expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>4.13, "20132014"=>4.2})
      end

      it "can tell us how many games there were in a season" do
        expect(@stat_tracker.count_of_games_by_season).to eq({"20122013" => 15, "20132014" => 5})
      end
    end
end
