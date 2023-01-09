# require './spec/spec_helper'
require './lib/stat_tracker'

describe StatTracker do
  let(:stat_tracker) {StatTracker.from_csv({
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
    it 'returns the total number of goals' do
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
    it 'returns percentage of wins at home' do
      expect(stat_tracker.percentage_home_wins).to eq(0.50)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns percentage of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.37)
    end
  end

  describe '#percentage_ties' do
    it 'returns percentage of tied games' do
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
      expect(stat_tracker.average_win_percentage("14")).to eq 0.50
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
      expect(stat_tracker.fewest_goals_scored("1")).to eq 1
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

  describe '#count_of_games_by_season' do
    it 'returns a hash of the number of games(values) per season(keys)' do
      expected_hash = {
        "20122013" => 10,
        "20132014" => 10,
        "20142015" => 10,
        "20152016" => 10,
        "20162017" => 10,
        "20172018" => 10
      }

      expect(stat_tracker.count_of_games_by_season).to eq(expected_hash)
    end
  end

  describe '#average_goals_per_game' do
    it 'returns the average number of goals per game' do
      expect(stat_tracker.average_goals_per_game).to eq(4.35)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns a hash of the average goals(values) by season(keys)' do
      expected_hash = {
        "20122013" => 3.90,
        "20132014" => 4.60,
        "20142015" => 4.40,
        "20152016" => 4.70,
        "20162017" => 4.00,
        "20172018" => 4.50
      }
      
      expect(stat_tracker.average_goals_by_season).to eq(expected_hash)
    end
  end

  describe '#game_ids_for_season(season)' do
    it 'collects the game ids for a given season' do
      expect(stat_tracker.game_ids_for_season("20152016")).to be_a(Array)
      expect(stat_tracker.game_ids_for_season("20152016").size).to eq(10)
    end
  end
  
  describe '#winningest_coach(season)' do
    it 'returns the coach with the best win percentage for the season' do
      expect(stat_tracker.winningest_coach("20152016")).to eq("Joel Quenneville")
      expect(stat_tracker.winningest_coach("20122013")).to eq("Guy Boucher").or(eq("Adam Oates"))
    end
  end

  describe '#worst_coach(season)' do
    it 'returns the coach with the worst win' do
      expect(stat_tracker.worst_coach("20162017")).to eq("Jared Bednar")
      expect(stat_tracker.worst_coach("20122013")).to eq("Michel Therrien").or(eq("Joe Sacco"))
    end
  end

  describe '#season_total_tackles(season)' do
    it 'returns a hash of total tackles by each team for the season' do
      expected_hash = {
        "15" => 84,
        "54" => 59,
        "14" => 33,
        "30" => 73,
        "52" => 137,
        "1" => 46,
        "21" => 49,
        "29" => 30
      }

      expect(stat_tracker.season_total_tackles("20172018")).to eq(expected_hash)
    end
  end

  describe '#most_tackles(season)' do
    it 'returns the team name with the most tackles for the season' do
      expect(stat_tracker.most_tackles("20122013")).to eq("Orlando City SC")
      expect(stat_tracker.most_tackles("20172018")).to eq("Portland Thorns FC")
    end
  end

  describe '#fewest_tackles(season)' do
    it 'returns the team name with the fewest tackels for the season' do
      expect(stat_tracker.fewest_tackles("20122013")).to eq("New York Red Bulls")
      expect(stat_tracker.fewest_tackles("20172018")).to eq("Orlando Pride")
    end
  end

  describe '#team_shots_by_season(season)' do
    it 'returns a hash with the team_id(key) and total shots for the season(value)' do
      expected_hash = {
        '8' => 5,
        '1' => 12,
        '30' => 41,
        '16' => 41,
        '3' => 15,
        '15' => 16,
        '21' => 7,
        '14' => 6
      }

      expect(stat_tracker.team_shots_by_season("20122013")).to eq(expected_hash)
    end
  end

  describe '#team_goals_by_season(season)' do
    it 'returns a hash with the team_id(key) and total goals for the season(value)' do
      expected_hash = {
        '8' => 2,
        '1' => 5,
        '30' => 10,
        '16' => 13,
        '3' => 1,
        '15' => 4,
        '21' => 1,
        '14' => 3
      }

      expect(stat_tracker.team_goals_by_season("20122013")).to eq(expected_hash)
    end
  end

  describe '#team_shots_to_goals_ratio(season)' do
    it 'returns a hash with the team_id(key) and shots-to-goals ratio for the season(value)' do
      expected_hash = {
        '8' => 2.50,
        '1' => 2.40,
        '30' => 4.10,
        '16' => 3.1538461538461537,
        '3' => 15.00,
        '15' => 4.00,
        '21' => 7.00,
        '14' => 2.00
      }

      expect(stat_tracker.team_shots_to_goals_ratio("20122013")).to eq(expected_hash)
    end
  end

  describe '#most_accurate_team' do
    it 'returns the team with the best ratio of shots to goals for the season' do
      expect(stat_tracker.most_accurate_team("20122013")).to eq("DC United")
    end
  end

  describe '#least_accurate_team' do
    it 'returns the team with the highest ratio of shots to goals for the season' do
      expect(stat_tracker.least_accurate_team("20122013")).to eq("Houston Dynamo")
    end
  end
end