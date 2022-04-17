require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

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

    # xit 'can load collections' do
    #
    #   expect(stat_tracker.load_collections(locations)).to eq({
    #     games => CSV.read(locations[:games], headers:true,
    #        header_converters: :symbol),
    #     teams =>,
    #     game_teams =>
    #     })
    #   collections is the key with the data as the value so that
    # end
    describe 'League Statistics' do
      it '#count_of_teams can count teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
      end

      it '#best_offense finds team with the best offense' do
        expect(@stat_tracker.best_offense).to eq(["Atlanta United",
           "Orlando City SC", "Portland Timbers", "San Jose Earthquakes"])
      end

      it '#worst_offense finds team with the worst offense' do
        expect(@stat_tracker.worst_offense).to eq("Seattle Sounders FC")
      end

      it '#lowest_scoring_visitor finds team with the lowest average away goals' do
        expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
      end

      it '#lowest_scoring_home_team finds team with the lowest average home goals' do
        expect(@stat_tracker.lowest_scoring_home_team).to eq("Seattle Sounders FC")
      end

      it '#highest_scoring_home_team finds team with the highest average home goals' do
        expect(@stat_tracker.highest_scoring_home_team).to eq(["Orlando City SC", "San Jose Earthquakes"])
      end

      it '#team_name_helper finds team name via team_id' do
        expect(@stat_tracker.team_name_helper("3")).to eq("Houston Dynamo")
      end


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
    end


end
