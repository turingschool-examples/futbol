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
			expect(stat_tracker.highest_total_score).to eq(20)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest point value game' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

	describe '#most_goals_scored' do
		it 'returns an integer of the most goals scored by a particular team in a single game' do
			expect(stat_tracker.most_goals_scored).to eq(9)
		end
	end
end