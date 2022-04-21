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

        expect(@stat_tracker.games_by_season("20122013").length).to eq(1612)
        expect(@stat_tracker.games_by_season("20122013")).to be_a(Array)
      end

      it "organizes stats by season" do

        expect(@stat_tracker.stats_by_season).to eq([])

      end

      it "calculates the winning percentage per team per season" do


        expect(@stat_tracker.organize_teams("20122013")).to eq Hash
        expect(@stat_tracker.team_winning_percentage_by_season("20122013")).to eq Hash
      end

      xit "returns head coach given team_id" do

        expect(@stat_tracker.head_coach_name("3")).to eq(("John Tortorella"))

      end

      xit "returns winningest head coach" do

        expect(@stat_tracker.winningest_coach("2012030221")).to eq(("Claude Julien"))

      end

      xit "returns loser head coach" do

        expect(@stat_tracker.worst_coach("2012030221")).to eq(("Gerard Gallant"))

      end

      xit "returns calculates the shooting percentage per team per season" do


        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["3"]).to eq(0.25)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["8"]).to eq(0.29)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["26"]).to eq(0.3)
        expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["30"]).to eq(0.28)
      end

      xit "defines team name by team_id" do

        expect(@stat_tracker.team_name("3")).to eq(("Houston Dynamo"))
      end

      xit "returns most accurate team" do


        expect(@stat_tracker.most_accurate_team("20122013")).to eq(("DC United"))
      end

      xit "returns least accurate team" do

        expect(@stat_tracker.least_accurate_team("20122013")).to eq(("Houston Dynamo"))

      end

      xit "returns the total number of tackles per team in a season" do

        expect(@stat_tracker.total_tackles_by_season("20122013")).to be_a(Hash)

      end

      xit "returns the team with the most tackles" do

        expect(@stat_tracker.most_tackles("2012030221")).to be_a(String)
      end

      xit "returns the team with the least amount of tackles" do

        expect(@stat_tracker.fewest_tackles("2012030221")).to be_a(String)
      end
    end
end
