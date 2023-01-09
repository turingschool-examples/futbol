require './spec/spec_helper'

describe TeamStats do
	before do
		game_path = './data/games_sample.csv'
		game_teams_path = './data/game_teams_sample.csv'
		team_path = './data/teams.csv'
		@games = Game.create_games(game_path)
		@game_teams = GameTeams.create_game_teams(game_teams_path)
		@teams = Team.create_teams(team_path)
	end

	let(:stat) {TeamStats.new(@teams, @games, @game_teams)}

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(TeamStats)
		end

		it 'has attributes' do
			expect(stat.teams).to include(Team)
			expect(stat.games).to include(Game)
			expect(stat.game_teams).to include(GameTeams)
		end
	end

	describe '#team_info' do
		it 'returns a hash of team info by passing a team_id argument' do
			expected_hash = {
				'team_id' => 8,
				'franchise_id' => 1,
				'team_name' => "New York Red Bulls",
				'abbreviation' => "NY",
				'link' => "/api/v1/teams/8"
			}
			expect(stat.team_info(8)).to eq(expected_hash)
		end
	end

	describe '#most_goals_scored' do
		it 'returns an integer of the most goals scored by a particular team in a single game' do
			expect(stat.most_goals_scored(6)).to eq(4)
			expect(stat.most_goals_scored(13)).to eq(2)
		end
	end

	describe '#fewest_goals_scored' do
		it 'returns an integer of the lowest goals scored by a particular team in a single game' do
			expect(stat.fewest_goals_scored(6)).to eq(2)
			expect(stat.fewest_goals_scored(5)).to eq(0)
		end
	end

	describe '#favorite_opponent' do
		it 'names of opponent that has lowest win % against given team' do
			expect(stat.favorite_opponent(52)).to eq("Chicago Red Stars")
		end
	end

	describe '#rival' do
		it 'names of opponent that has highest win % against given team' do
			expect(stat.rival(52)).to eq("Sporting Kansas City")
		end
	end

  describe '#best_season' do
    it 'returns the season with the highest win percentage for a team argument' do
      expect(stat.best_season('5')).to eq('20172018')
    end
  end

  describe '#worst_season' do
    it 'returns the season with the lowest win percentage for a team' do
      expect(stat.worst_season('5')).to eq('20122013')
    end
  end
end