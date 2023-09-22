require './spec/spec_helper'

RSpec.describe StatTracker do
  game_path = './data/games_fixture.csv'
  team_path = './data/teams_fixture.csv'
  game_teams_path = './data/game_teams_fixture.csv'
  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  
  let(:stat_tracker) { StatTracker.from_csv(locations) }

  describe '#initialize' do
    it 'can initialize' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'returns an instance of StatTracker' do
      expect(stat_tracker).to be_a(StatTracker)
      expect(stat_tracker.team_data).to be_a(CSV::Table)
      expect(stat_tracker.game).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest sum of the winning and losing teams scores' do
      expect(stat_tracker.highest_total_score).to eq(6)
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams scores' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it 'calculates percentage home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.45)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'calculates the percentage of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.20)
    end
  end

  describe '#percentage_ties' do
    it 'calculates the percentage of tied games' do
      expect(stat_tracker.percentage_ties).to eq(0.35)
    end
  end

  describe '#count_of_games_by_season' do
    it 'counts games by season' do
      expected = {
        "20122013" => 6,
        "20132014" => 9,
        "20142015" => 5,
      }
      expect(stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#average_goals_per_game' do
    it 'returns the average number of goals scored by a single team' do
      expect(stat_tracker.average_goals_per_game).to eq(1.98)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns the average goals scored per season' do
      expected_value = { '20122013' => 3.67, '20132014' => 3.78, '20142015' => 4.60 }
      expect(stat_tracker.average_goals_by_season).to eq(expected_value)
    end
  end

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(stat_tracker.count_of_teams).to eq(4)
    end
  end

  describe '#best_offense' do
    it 'list best offense' do
      expect(stat_tracker.best_offense).to eq("Houston Dynamo")
    end
  end

  describe '#worst_offense' do
    it 'can return the team with the lowest average number of goals per game across all seasons' do
      expect(stat_tracker.worst_offense).to eq("Seattle Sounders FC")
    end
  end

  describe '#games_and_scores' do
    it 'returns a hash with team id, games played, total score and average' do
      expected ={ "1"=>{:games_played=>9, :total_score=>16, :average=>1.78},
      "2"=>{:games_played=>11, :total_score=>19, :average=>1.73},
      "3"=>{:games_played=>11, :total_score=>25, :average=>2.27},
      "4"=>{:games_played=>9, :total_score=>19, :average=>2.11}}
      expect(stat_tracker.games_and_scores).to eq(expected)
    end
  end

  describe '#number_of_games' do
    it 'returns number of game' do
      expect(stat_tracker.number_of_games("1")).to eq(9)
    end
  end

  describe '#total_score_for_teams' do
    it 'returns total scores for teams' do
      expect(stat_tracker.total_score_for_teams("1")).to eq(16)
    end
  end

  describe '#highest_scoring_home_team' do
    it 'return the highest scoring home team' do
      expect(stat_tracker.highest_scoring_home_team).to eq("Houston Dynamo")
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns the team with the highest average number of goals per game when away' do
      expect(stat_tracker.highest_scoring_visitor).to eq("Seattle Sounders FC")
    end
  end

  # describe '#home_team?(team_id)' do
  #   xit '' do
  #     expect(stat_tracker.lowest_scoring_home_team).to eq('Seattle Sounders FC')
  #   end
  # end

  describe '#lowest_scoring_home_team' do
    it 'returns name of the team with the lowest average score per home game across all seasons' do
      expect(stat_tracker.lowest_scoring_home_team).to eq('Seattle Sounders FC')
    end
  end
  # Add test for lowest scoring home team helper method

  describe '#lowest_scoring_visitor' do
    it 'returns name of the team with the lowest average score per home game across all seasons' do
      expect(stat_tracker.lowest_scoring_visitor).to eq('Chicago Fire')
    end
  end


  describe '#most_accurate_team' do
    it 'returns name of the team with the highest percentage of goals made vs. shots taken' do
      expect(stat_tracker.most_accurate_team("20122013")).to eq('Atlanta United')
      expect(stat_tracker.most_accurate_team("20132014")).to eq('Chicago Fire')
      expect(stat_tracker.most_accurate_team("20142015")).to eq('Houston Dynamo')
    end
  end




  describe '#least_accurate_team' do
    it 'list least accurate team' do
      expect(stat_tracker.least_accurate_team("20122013")).to eq("Seattle Sounders FC")
    end
  end

  describe '#teams_shots_goals_ratio' do
    it 'returns a hash of team id and total score to total shot ratio' do
      expected = {
        "1" => {:ratio => 0.38},
        "2"=> {:ratio => 0.23},
        "3"=> {:ratio => 0.28},
        "4"=> {:ratio => 0.27},
      }
      expect(stat_tracker.teams_shots_goals_ratio("20122013")).to eq(expected)
    end
  end
  
  describe '#season_total_goals' do
    it 'returns total goals made by a team' do
      expect(stat_tracker.season_total_goals("1", "20122013")).to eq(5)
    end
  end
  
  describe '#season_total_shots' do
    it 'returns total shots made by a team' do
      expect(stat_tracker.season_total_shots("1", "20122013")).to eq(13)
    end
  end

  describe '#season' do
    it 'returns list of games in that season' do
      expect(stat_tracker.season("20122013").class).to eq(Array)
      expect(stat_tracker.season("20122013").first[:game_id]).to eq("2012020122")
    end
  end

end