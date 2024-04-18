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

    describe "#count_of_games_by_season" do
        it "can count total games in one season" do
            expect(@stat_tracker.count_of_games_by_season).to eq ({"20122013" => 10})
        end

    end

    describe "#average_goals_per_game" do
        it "can determine average goals of a given game" do
            expect(@stat_tracker.average_goals_per_game).to eq (1.85)
        end

    end

end

