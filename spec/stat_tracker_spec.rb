require './lib/stat_tracker'
# require './spec/spec_helper'

describe StatTracker do
  let(:stat_tracker) {StatTracker.new({
                        :games => './data/games_spec.csv', 
                        :teams => './data/teams.csv', 
                        :game_teams => './data/game_teams_spec.csv'
                        })}
  
  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end

    it 'has attributes' do
      expect(stat_tracker.games).to be_a(CSV::Table)
      expect(stat_tracker.teams).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
    end
  end

  describe '#total_score' do
    it 'calculates the total number of goals' do
      expect(stat_tracker.total_score).to be_a(Array)
      expect(stat_tracker.total_score.sum).to eq(261)
    end
  end

  describe '#highest_total_score' do
    it 'returns highest sum of the winning and losing teams scores' do
      expect(stat_tracker.highest_total_score).to eq(9)
    end
  end

  describe '#lowest_total_score' do
    it 'returns lowest sum of the winning and losing teams scores' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it 'returns percent of wins at home' do
      expect(stat_tracker.percentage_home_wins).to eq(0.5)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns percent of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.37)
    end
  end

  describe '#percentage_ties' do
    it 'returns percent of tied games' do
      expect(stat_tracker.percentage_ties).to eq(0.13)
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

  describe '#away_goals_by_id' do
    it "creates a hash of away goals by id" do
      expect(stat_tracker.away_goals_by_team_id).to be_a(Hash)
    end
  end

  describe '#away_games_by_team_id' do
    it "creates a hash of away games by team id" do
      expect(stat_tracker.away_games_by_team_id).to be_a(Hash)
    end
  end

  describe '#away_goal_avg_per_game' do
    it "creates a hash of average away goals per game" do
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

  describe '#highest_scoring_home_team' do
    it "team with the highest average score per game across all seasons when they are away" do
      expect(stat_tracker.highest_scoring_home_team).to eq "Sporting Kansas City"
    end
  end

  describe '#home_games_by_team_id' do
    it "creates a hash of home games by team id" do
      expect(stat_tracker.home_games_by_team_id).to be_a(Hash)
    end
  end

  describe '#home_goal_avg_per_game' do
    it "creates a hash of average home goals per game" do
      expect(stat_tracker.home_goal_avg_per_game).to be_a(Hash)
    end
  end

  describe '#average_win_percentage' do
    it "states avg win percentage of a specific team by team ID" do
      expect(stat_tracker.average_win_percentage("14")).to eq 0.57
    end
  end

  describe '#goals_by_team_id' do
    it "creates an array of goals per team ID" do
      expect(stat_tracker.goals_by_team_id("14")).to eq([2, 1, 2, 3, 2, 0, 3, 2, 4, 2, 2, 3, 1, 2])
    end
  end

  describe '#most_goals_scored' do
    it "returns the highest number of goals a team has scored in a single game" do
      expect(stat_tracker.most_goals_scored("14")).to eq 4
    end
  end

  describe '#fewest_goals_scored' do
    it "returns the lowest number of goals a team has scored in a single game" do
      expect(stat_tracker.fewest_goals_scored("18")).to eq 3
    end
  end
  describe '#team_info' do
    it 'returns a hash of team_id, franchise_id, team_name, abbreviation, link for a specific team' do
      expect(stat_tracker.team_info("1")).to eq({"team_id" => "1", "franchise_id" => "23", "team_name" => "Atlanta United", "abbreviation" => "ATL", "link" => "/api/v1/teams/1"})
      expect(stat_tracker.team_info("14")).to eq({"team_id" => "14", "franchise_id" => "31", "team_name" => "DC United", "abbreviation" => "DC", "link" => "/api/v1/teams/14"})
    end
  end

  describe '#best_season' do
    it 'Season with the highest win percentage for a team' do
      expect(stat_tracker.best_season("1")).to eq("20132014")
      expect(stat_tracker.best_season("14")).to eq("20122013")
    end
  end

  describe '#worst_season' do
    it 'Season with the lowest win percentage for a team' do
      expect(stat_tracker.worst_season("3")).to eq("20142015")
      expect(stat_tracker.worst_season("29")).to eq("20142015")
    end
  end

  describe '#favorite_opponent' do
    it 'Name of the opponent that has the lowest win percentage against the given team' do
      expect(stat_tracker.favorite_opponent("3")).to eq("Atlanta United").or(eq("Orlando City SC"))
    end
  end

  describe '#rival' do
    it 'Name of the opponent that has the highest win percentage against the given team' do
      expect(stat_tracker.rival("3")).to eq("DC United")
    end
  end



end





