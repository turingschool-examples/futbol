require_relative './spec_helper'
require_relative '../lib/team_statistics'
require './lib/stat_tracker'
require 'csv'

RSpec.describe TeamStatistics do
    before(:all) do
        game_path = './data/fixture_data_team_satistics/fixture_games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/fixture_data_team_satistics/fixture_game_teams.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
        }

        stat_tracker = StatTracker.from_csv(locations)
        @team_statistics = TeamStatistics.new(stat_tracker)
    end

    describe ".team_satistics instantiation" do
        context "object exists as an instantiation of class" do
            it 'is instance of class' do
                expect(@team_statistics).to be_an_instance_of(TeamStatistics)
            end
        end
    end

    describe ".team_info" do
        context "team_info returns a hash" do
            hash_output = {
                team_id: "1",
                franchise_id: "23",
                team_name: "Atlanta United",
                abbreviation: "ATL",
                link: "/api/v1/teams/1"
            }

            it 'returns a hash' do
                @team_statistics.team_info("1")
                # expect(@team_statistics.team_info("1")).to be_in(Hash)
            end
            xit 'returns team_id, franchise_id, team_name, abbreviation, and link' do
                expect(@team_statistics.team_info("1")).to eq(hash_output)
            end
        end
    end

    # describe ".best_season" do
    #     context "best_season returns a string" do
    #         xit 'returns a string' do
    #             expect(team_statistics.best_season("6")).to be_in(String)
    #         end
    #         xit 'returns highest win percentage' do
    #             expect(team_statistics.best_season("6").to eq("20132014"))
    #         end
    #     end
    # end

    # describe ".worst_season" do
    #     context "worst_season returns a string" do
    #         xit 'returns a string' do
    #             expect(team_statistics.worst_season("6")).to be_in(String)
    #         end
    #         xit 'returns highest win percentage' do
    #             expect(team_statistics.worst_season("6").to eq("20142015"))
    #         end
    #     end
    # end

    # describe ".average_win_percentage" do
    #     context "average_win_percentage returns a float" do
    #         xit 'returns a float' do
    #             expect(team_statistics.average_win_percentage("6")).to be_in(Float)
    #         end
    #         xit 'returns average win percentage' do
    #             expect(team_statistics.average_win_percentage("6")).to eq(0.49)
    #         end
    #     end
    # end

end