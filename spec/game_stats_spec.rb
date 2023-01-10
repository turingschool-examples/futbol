require 'csv'
require 'spec_helper.rb'

RSpec.describe GameStats do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  # let(:stats) { Stats.new(locations) }
  let(:game_stats) { GameStats.new(locations) }
  describe "Game Statisics" do
    it "#highest_total_score" do
      expect(game_stats.highest_total_score).to eq(9)
    end

    it "#lowest_total_score" do
      expect(game_stats.lowest_total_score).to eq(1)
    end

    it "#percentage_home_wins" do
      expect(game_stats.percentage_home_wins).to eq(0.41)
    end

    it "#percentage_visitor_wins" do
      expect(game_stats.percentage_visitor_wins).to eq(0.47)
    end

    it "#percentage_ties" do
      expect(game_stats.percentage_ties).to eq(0.15)
    end

    it "#count_of_games_by_season" do 
      expect(game_stats.count_of_games_by_season).to eq({
        "20162017" => 7, 
        "20172018" => 10, 
        "20152016" => 2, 
        "20142015" => 10, 
        "20122013" => 5, 
        "20132014" => 13, 
      })
    end

    it "#average_goals_per_game" do 
      expect(game_stats.average_goals_per_game).to eq(4.45)
    end

    it "#average_goals_by_season" do 
      expect(game_stats.average_goals_by_season).to eq({
        "20162017" => 5.14, 
        "20172018" => 4.10, 
        "20152016" => 6.00, 
        "20142015" => 3.90, 
        "20122013" => 5.00, 
        "20132014" => 4.31, 
      })
    end 
  end
end