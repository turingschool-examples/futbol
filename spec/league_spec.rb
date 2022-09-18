require 'spec_helper'
require './lib/league'

RSpec.describe League do
  before (:all) do
    fixture_game_path = 'fixture/games.csv'
    fixture_team_path = 'fixture/teams.csv'
    fixture_game_teams_path = 'fixture/game_teams.csv'

    locations = {
      games: fixture_game_path,
      teams: fixture_team_path,
      game_teams: fixture_game_teams_path
    }
    
    @league = League.new(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@league).to be_an_instance_of(League)
    end
  end

  describe '#league' do
    it '#team_goals_per_game' do
      team_with_goals = {
        "6" => [3,3,2,3,3,3,4,2,1,2],    
        "3" => [2,2,1,2,1,2,2,2,2,1],    
        "5" => [0,1,1,0,3],    
        "17" => [1],    
        "16" => [2,5,3],    
        "25" => [3,3,2],    
        "30" => [2,2,1,3,1,2,2,1],    
        "19" => [2,2,0,4,1,1],    
        "15" => [3,1,3,3,3,3,2,2,2,4,1,2,2],    
        "14" => [2,4,2,2,1,2,2],    
        "8" => [1,2,1,4,2,1],    
        "10" => [2,2,2,2,1,1],    
        "29" => [1,1,3,3,1,2],    
        "52" => [2,2,5,1,4,2],    
        "18" => [1,3,2,2,2,2],    
        "20" => [3,1],    
        "28" => [4,2],    
        "4" => [2,2],    
        "26" => [2],    
        "24" => [2],    
        "22" => [2],    
        "12" => [3],    
        "13" => [0]    
      }
      expect(@league.team_goals_per_game).to eq(team_with_goals)
    end
  end

  describe '#team_average_goals_per_game' do
    it 'returns a hash with the average score for all games per team id' do
      team_with_goal_average = {
        "6" => 2.6,    
        "3" => 1.7,    
        "5" => 1.0,    
        "17" => 1.0,    
        "16" => 3.333,    
        "25" => 2.667,    
        "30" => 1.75,    
        "19" => 1.667,    
        "15" => 2.385,    
        "14" => 2.143,    
        "8" => 1.833,    
        "10" => 1.667,    
        "29" => 1.833,    
        "52" => 2.667,    
        "18" => 2.0,    
        "20" => 2.0,    
        "28" => 3.0,    
        "4" => 2.0,    
        "26" => 2.0,    
        "24" => 2.0,    
        "22" => 2.0,    
        "12" => 3.0,    
        "13" => 0.0    
      }
      expect(@league.team_average_goals_per_game).to eq(team_with_goal_average)
    end
  end

  describe '#League Statistics' do
    it 'returns the number of teams in the league' do
      expect(@league.count_of_teams).to eq 32
    end

    it 'returns the team with highest average number of goals scored per game all seasons' do
      expect(@league.best_offense).to eq "New England Revolution"
    end

    it 'returns the worst offense' do
      expect(@league.worst_offense).to eq "Houston Dash"
    end

    it "#highest_scoring_visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq ""
    end

    it "#highest_scoring_home_team" do
      expect(@league.highest_scoring_home_team).to eq ""
    end

    it "#lowest_scoring_visitor" do
      expect(@league.lowest_scoring_visitor).to eq ""
    end

    it "#lowest_scoring_home_team" do
      expect(@league.lowest_scoring_home_team).to eq ""
    end
  end
end

