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

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#average_goals_per_game' do
    it 'can return the average total score of all games played rounded to the 100th' do
      expect(stat_tracker.average_goals_per_game).to eq(4.029)
    end
  end

end