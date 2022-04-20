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

    describe 'Team Statistics' do
      it '#team_info can put team info into a hash' do
        expected = {
          "team_id" => "1",
          "franchise_id" => "23",
          "team_name" => "Atlanta United",
          "abbreviation" => "ATL",
          "link" => "/api/v1/teams/1"
        }

        expect(@stat_tracker.team_info("1")).to eq(expected)
      end

      it 'can identify the season through the game id' do
        expect(@stat_tracker.season_games("2012030221")).to eq("20122013")
      end

      it '#best_season can determine the best season for a team' do
        expect(@stat_tracker.best_season("24")).to eq("20122013")
      end

      it '#worst_season can determine the best season for a team' do
        expect(@stat_tracker.worst_season("24")).to eq("20132014")
      end

      it '#average_win_percentage can determine the average wins of all games for a team' do
        expect(@stat_tracker.average_win_percentage("3")).to eq(0.0)
      end

      it '#most_goals_scored can find the highest number of goals a team has scored in a game' do
        expect(@stat_tracker.most_goals_scored("3")).to eq(2)
      end

      it '#fewest_goals_scored can find the lowest number of goals a team has scored in a game' do

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

      it "can tell us the average goals per game" do
        expect(@stat_tracker.average_goals_per_game).to eq(4.15)
      end

      it "can tell us how many games there were in a season" do
        expect(@stat_tracker.count_of_games_by_season).to eq({"20122013" => 15, "20132014" => 5})
      end
    end

end
