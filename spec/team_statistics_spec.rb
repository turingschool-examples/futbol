require 'spec_helper'
require_relative '../lib/team_statistics'
require './lib/stat_tracker'

RSpec.describe TeamStatistics do
    before(:all) do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
        }

        stat_tracker = StatTracker.from_csv(locations)
        @team_statistics = TeamStatistics.new(stat_tracker.data)
    end
    describe ".team_satistics instantiation" do
        it 'is instance of class' do
            expect(@team_statistics).to be_an_instance_of(TeamStatistics)
        end
    end
    describe ".team_info" do
        hash_output = {
            "team_id" => "1",
            "franchise_id" => "23",
            "team_name" => "Atlanta United",
            "abbreviation" => "ATL",
            "link" => "/api/v1/teams/1"
        }
        it 'returns team_id, franchise_id, team_name, abbreviation, and link' do
            expect(@team_statistics.team_info("1")).to eq(hash_output)
        end
    end
    describe ".best_season" do
        it 'returns highest win percentage' do
            expect(@team_statistics.best_season("6")).to eq("20132014")
        end
    end
    describe ".worst_season" do
        it 'returns highest win percentage' do
            expect(@team_statistics.worst_season("6")).to eq("20142015")
        end
    end
end