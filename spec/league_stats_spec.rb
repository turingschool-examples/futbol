require './lib/csv_reader'
require './lib/league_stats'

RSpec.describe LeagueStats do
    before :each do
        @game_path = './data/dummy_games.csv'
        @team_path = './data/teams.csv'
        @game_teams_path = './data/dummy_game_teams.csv'

        @locations = {
          games: @game_path,
          teams: @team_path,
          game_teams: @game_teams_path
        }

        @league_stats = LeagueStats.new(@locations)
    end

    describe 'League Statistics' do
        it 'exists' do
            expect(@league_stats).to be_a(LeagueStats)
        end

        it '#count_of_teams can count teams' do
        expect(@league_stats.count_of_teams).to eq(32)
        end

        it '#best_offense finds team with the best offense' do
          expect(@league_stats.best_offense).to eq("Atlanta United, " +
             "Orlando City SC, Portland Timbers, San Jose Earthquakes")
        end

        it '#worst_offense finds team with the worst offense' do
          expect(@league_stats.worst_offense).to eq("Seattle Sounders FC")
        end

        it '#hightest_scoring_visitor finds the team with the hightest scoring visitor' do
            expect(@league_stats.highest_scoring_visitor).to eq(
              "Portland Timbers, Real Salt Lake, Atlanta United, FC Dallas")
        end

        it '#lowest_scoring_visitor finds team with the lowest average away goals' do
          expect(@league_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
        end

        it '#lowest_scoring_home_team finds team with the lowest average home goals' do
          expect(@league_stats.lowest_scoring_home_team).to eq("Seattle Sounders FC")
        end

        it '#highest_scoring_home_team finds team with the highest average home goals' do
          expect(@league_stats.highest_scoring_home_team).to eq("Orlando City SC, San Jose Earthquakes")
        end

        it '#team_name_helper finds team name via team_id' do
          expect(@league_stats.team_name_helper("3")).to eq("Houston Dynamo")
        end
    end
end
