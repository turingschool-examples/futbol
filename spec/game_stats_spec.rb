require 'spec_helper.rb'

RSpec.describe LeagueStats do
  before(:each) do
    @game_path = './data/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_fixture.csv'
    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    end

    describe "#count_of_games_by_season"
        it "#total_points" d
            expect(@stat_tracker.count_of_games_by_season.to eq 11
        end
    end
end

