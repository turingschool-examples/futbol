require './spec/spec_helper'
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