require './spec/spec_helper'

describe GameStats do
	before do
		game_path = './data/games_sample.csv'
		game_teams_path = './data/game_teams_sample.csv'
    teams_path = './data/teams.csv'
		@games = Game.create_games(game_path)
		@game_teams = GameTeams.create_game_teams(game_teams_path)
    @teams = Team.create_teams(teams_path)
	end

	let(:stat) {GameStats.new(@games, @game_teams, @teams)}

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(GameStats)
		end

		it 'has attributes' do
			expect(stat.games).to include(Game)
		end
	end

  describe '#average_goals_per_game' do
    it 'can return the average total score of all games played rounded to the 100th' do
      expect(stat.average_goals_per_game).to eq(4.03)
    end
  end
	
	describe '#percentage_home_wins' do
    it 'returns % of home team wins (rounded to the nearest 100th)' do
      expect(stat.percentage_home_wins).to eq(0.46)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns % of visitor team wins (rounded x.xx)' do
      expect(stat.percentage_visitor_wins).to eq(0.42)
    end
  end

	describe '#percentage_ties' do
    it 'returns % of ties (rounded x.xx)' do
      expect(stat.percentage_ties).to eq(0.14)
    end
  end

  describe '#average_goals_per_game' do
    it 'can return the average total score of all games played rounded to the 100th' do
      expect(stat.average_goals_per_game).to eq(4.03)
    end
  end

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(stat.count_of_teams).to eq(32)
    end
  end
end