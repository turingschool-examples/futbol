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

  xdescribe '#fewest_tackles' do
    it 'returns the NAME of team with fewest tackles the in SEASON' do
      expect(stat.fewest_tackles(20162017)).to eq("Montreal Impact")
    end
  end
end