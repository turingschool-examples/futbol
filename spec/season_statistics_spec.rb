require './spec/spec_helper'

describe SeasonStats do
	before do
		game_path = './data/games_sample.csv'
		game_teams_path = './data/game_teams_sample.csv'
		team_path = './data/teams.csv'
		@games = Game.create_games(game_path)
		@game_teams = GameTeams.create_game_teams(game_teams_path)
		@teams = Team.create_teams(team_path)
	end

	let(:stat) {SeasonStats.new(@games, @game_teams, @teams)}

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(SeasonStats)
		end

		it 'has attributes' do
			expect(stat.games).to include(Game)
			expect(stat.game_teams).to include(GameTeams)
		end
	end

	describe '#most_tackles' do
    it 'returns the NAME of team with most tackles in the SEASON' do
      expect(stat.most_tackles(20162017)).to eq("New York City FC")
    end
  end

  describe '#fewest_tackles' do
    it 'returns the NAME of team with fewest tackles the in SEASON' do
      expect(stat.fewest_tackles(20162017)).to eq("Montreal Impact")
    end
  end

	describe '#winningest_coach' do
		it 'names the coach with the best win percentage for the season' do
			expect(stat.winningest_coach(20162017)).to eq("Glen Gulutzan")
		end
	end

	describe '#worst_coach' do
		it 'names the coach with the worst percentage for the reason' do
			expect(stat.worst_coach(20162017)).to eq('Randy Carlyle')
		end
	end

	describe '#most_accurate_team' do
		it 'returns TEAM NAME with the BEST ratio of SHOTS to GOALS for the SEASON' do
      expect(stat.most_accurate_team(20162017)).to eq("Toronto FC")
		end
	end

	describe '#least_accurate_team' do
		it 'returns TEAM NAME with the WORST ratio of SHOTS to GOALS for the SEASON' do
      expect(stat.least_accurate_team(20162017)).to eq("DC United")
		end
	end

end