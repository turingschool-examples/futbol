require './lib/game_stats'
require './lib/csv_reader'
require 'csv'

RSpec.describe GameStats do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @game_stats = GameStats.new(@locations)
    end

    describe "Game statistics" do

      it "can tell us the highest scoring game" do
        expect(@game_stats.highest_total_score).to eq(6)
      end

      it "can tell us the lowest scoring game" do
        expect(@game_stats.lowest_total_score).to eq(1)
      end

      it "can tell us the percentage of home games won" do
        expect(@game_stats.percentage_home_wins).to eq(0.45)
      end

      it "can tell us the percentage of away games won" do
        expect(@game_stats.percentage_visitor_wins).to eq(0.35)
      end

      it "can tell us the percentage of ties" do
        expect(@game_stats.percentage_ties).to eq(0.15)
      end

      it "can tell us the average goals per game" do
        expect(@game_stats.average_goals_per_game).to eq(4.15)
      end

      it "can tell us the average goals per season" do
        expect(@game_stats.average_goals_by_season).to eq({"20122013"=>4.13, "20132014"=>4.2})
      end

      it "can tell us how many games there were in a season" do
        expect(@game_stats.count_of_games_by_season).to eq({"20122013" => 15, "20132014" => 5})
      end
    end

end
