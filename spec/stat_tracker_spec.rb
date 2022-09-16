require 'rspec'
require 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#game stats' do
    it 'can find total game score for each game' do 
      expect(@stat_tracker.total_game_goals.count).to eq(7441)
      expect(@stat_tracker.total_game_goals[4]).to eq(4)
      expect(@stat_tracker.total_game_goals[399]).to eq(6)
    end

    it 'can calculate the highest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'can calculate the lowest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it 'can calculate the percentage of games that a home team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'can calculate the percentage of games that an visitor team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it 'can calculate percentage of games that has resulted in a tie (rounded to the nearest 100th)' do 
      expect(@stat_tracker.percentage_ties).to eq(0.2)
    end

    it 'can calculate number of games by season' do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq expected
    end

    it 'can calculate the average goals per game' do 
      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end

    it 'can calculate the average goals by season' do
      expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
      }
      expect(@stat_tracker.average_goals_by_season).to eq expected
    end
  end





















































































































































  describe '#League Statistics' do
    it 'returns the number of teams in the league' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end

    it 'returns the team with highest average number of goals scored per game all seasons' do
      expect(@stat_tracker.best_offense).to eq "Reign FC"
    end

    it 'returns the worst offense' do
      expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end
  end
end