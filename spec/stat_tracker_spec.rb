require './spec/spec_helper'

describe StatTracker do
  before do
		game_path = './data/games_sample.csv'
		team_path = './data/teams.csv'
		game_teams_path = './data/game_teams_sample.csv'

		@locations = {
			games: game_path,
			teams: team_path,
			game_teams: game_teams_path
		}
	end

  let(:stat_tracker) { StatTracker.from_csv(@locations) }

	describe '#initialize' do
		it 'exists' do
			expect(stat_tracker).to be_a(StatTracker)
		end
	end

  describe '#highest_total_score' do
    it 'Highest point value game' do
			expect(stat_tracker.highest_total_score).to eq(7)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest point value game' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

	describe '#most_goals_scored' do
		it 'returns an integer of the most goals scored by a particular team in a single game' do
			expect(stat_tracker.most_goals_scored(6)).to eq(4)
			expect(stat_tracker.most_goals_scored(13)).to eq(2)
		end
	end

	describe '#fewest_goals_scored' do
		it 'returns an integer of the lowest goals scored by a particular team in a single game' do
			expect(stat_tracker.fewest_goals_scored(6)).to eq(2)
			expect(stat_tracker.fewest_goals_scored(5)).to eq(0)
		end
	end

	describe '#count_of_games_by_season' do
		it 'returns a hash with season names as keys and counts of games as values' do
			expected = {
				"20122013" => 8,
				"20132014" => 4,
				"20152016" => 6,
				"20162017" => 8,
				"20172018" => 9
			}
			expect(stat_tracker.count_of_games_by_season).to eq(expected)
		end
	end

	describe '#average_goals_by_season' do
		it 'returns a hash with seasons as keys and average goals per season as values' do
			expected = {
				"20122013" => 4.13,
				"20132014" => 5.0,
				"20152016" => 3.0,
				"20162017" => 4.38,
				"20172018" => 3.89
			}

			expect(stat_tracker.average_goals_by_season).to eq(expected)
		end
	end

	describe '#winingest_coach' do
		it 'names the coach with the best win percentage for the season' do
			expect(stat_tracker.winingest_coach(20162017))
		end
	end
end