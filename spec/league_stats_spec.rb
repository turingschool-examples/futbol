require './spec/spec_helper'
require './lib/stat_tracker'

describe LeagueStats do
  let(:stat_tracker) {StatTracker.from_csv({
                        :games => './data/games_spec.csv', 
                        :teams => './data/teams.csv', 
                        :game_teams => './data/game_teams_spec.csv'
                        })}
  
  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '#count_of_teams' do
    it "counts all teams" do
      stat_tracker.count_of_teams
      expect(stat_tracker.count_of_teams).to eq 32
    end
  end

  describe '#best_offense' do
    it "name of the team with the highest average number of goals scored per game across all seasons" do
      expect(stat_tracker.best_offense).to eq "Sporting Kansas City"
    end
  end

  describe '#worst_offense' do
    it "name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(stat_tracker.worst_offense).to eq "Houston Dynamo"
    end
  end

  describe '#away_goals_by_team_id' do
    xit "creates a hash of away goals by id" do
      expect(stat_tracker.away_goals_by_team_id).to be_a(Hash)
    end
  end

  describe '#away_games_by_team_id' do
    xit "creates a hash of away games by team id" do
      expect(stat_tracker.away_games_by_team_id).to be_a(Hash)
    end
  end

  describe '#away_goal_avg_per_game' do
    xit "creates a hash of average away goals per game" do
      expect(stat_tracker.away_goal_avg_per_game).to be_a(Hash)
    end
  end

  describe '#highest_scoring_visitor' do
    it "team with the highest average score per game across all seasons when they are away" do
      expect(stat_tracker.highest_scoring_visitor).to eq "Sporting Kansas City"
    end
  end

  describe '#lowest_scoring_visitor' do
    it "team with the lowest average score per game across all seasons when they are away" do
      expect(stat_tracker.lowest_scoring_visitor).to eq "Houston Dynamo"
    end
  end

  describe '#lowest_scoring_home_team' do
    xit "team with the lowest average score per game across all seasons when they are away" do
      expect(stat_tracker.lowest_scoring_home_team).to eq "   "
    end
  end

  describe '#highest_scoring_home_team' do
    it "team with the highest average score per game across all seasons when they are away" do
      expect(stat_tracker.highest_scoring_home_team).to eq "Sporting Kansas City"
    end
  end
end
