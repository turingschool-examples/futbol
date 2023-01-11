require './spec/spec_helper'
require './lib/stat_tracker'

describe LeagueStats do
  let(:league_stats) {LeagueStats.new({
                        :games => './data/games_spec.csv', 
                        :teams => './data/teams.csv', 
                        :game_teams => './data/game_teams_spec.csv'
                        })}
  
  describe '#initialize' do
    it 'exists' do
      expect(league_stats).to be_a(LeagueStats)
    end
  end

  describe '#count_of_teams' do
    it "counts all teams" do
      expect(league_stats.count_of_teams).to eq 32
    end
  end

  describe '#teams_and_goals_data' do
   it 'creates teams_and_goals_data' do
    expect(league_stats.teams_and_goals_data).to be_a(Array)  
    expect(league_stats.teams_and_goals_data.size).to eq(120)
    end
  end

  describe '#offense_hash' do
    it 'creates_offense_hash' do
      expect(league_stats.offense_hash).to eq({"1"=>2.33, "10"=>2.14, "14"=>2.07, "15"=>2.3, "16"=>2.54, "21"=>1.91, "29"=>2.36, "3"=>1.25, "30"=>1.69, "5"=>3.5, "52"=>2.29, "54"=>3.0, "8"=>2.25})
    end
  end

  describe '#best_offense' do
    it "name of the team with the highest average number of goals scored per game across all seasons" do
      expect(league_stats.best_offense).to eq "Sporting Kansas City"
    end
  end

  describe '#worst_offense' do
    it "name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(league_stats.worst_offense).to eq "Houston Dynamo"
    end
  end

  describe '#away_goals_by_team_id' do
    it "creates a hash of away goals by id" do
      expect(league_stats.away_goals_by_team_id).to eq({"1"=>10, "10"=>6, "14"=>16, "15"=>19, "16"=>14, "21"=>8, "29"=>19, "3"=>1, "30"=>13, "5"=>3, "52"=>12, "8"=>4})
    end
  end

  describe '#away_games_by_team_id' do
    it "creates a hash of away games by team id" do
      expect(league_stats.away_games_by_team_id).to eq({"1"=>5, "10"=>3, "14"=>8, "15"=>8, "16"=>6, "21"=>4, "29"=>7, "3"=>2, "30"=>8, "5"=>1, "52"=>6, "8"=>2})
    end
  end

  describe '#away_goal_avg_per_game' do
    it "creates a hash of average away goals per game" do
      expect(league_stats.away_goal_avg_per_game).to eq({"1"=>2.0, "10"=>2.0, "14"=>2.0, "15"=>2.38, "16"=>2.33, "21"=>2.0, "29"=>2.71, "3"=>0.5, "30"=>1.63, "5"=>3.0, "52"=>2.0, "8"=>2.0})
    end
  end

  describe '#highest_scoring_visitor' do
    it "team with the highest average score per game across all seasons when they are away" do
      expect(league_stats.highest_scoring_visitor).to eq "Sporting Kansas City"
    end
  end

  describe '#lowest_scoring_visitor' do
    it "team with the lowest average score per game across all seasons when they are away" do
      expect(league_stats.lowest_scoring_visitor).to eq "Houston Dynamo"
    end
  end

  describe '#lowest_scoring_home_team' do
    it "team with the lowest average score per game across all seasons when they are away" do
      expect(league_stats.lowest_scoring_home_team).to eq "Houston Dynamo"
    end
  end

  describe '#highest_scoring_home_team' do
    it "team with the highest average score per game across all seasons when they are away" do
      expect(league_stats.highest_scoring_home_team).to eq "Sporting Kansas City"
    end
  end
end
