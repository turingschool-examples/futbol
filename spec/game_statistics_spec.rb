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

  describe '#count_of_games_by_season' do
    it 'returns a hash with season names as keys and counts of games as values' do
      expected = {
        "20122013" => 8,
        "20132014" => 4,
        "20152016" => 6,
        "20162017" => 8,
        "20172018" => 9
      }
      expect(stat.count_of_games_by_season).to eq(expected)
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

      expect(stat.average_goals_by_season).to eq(expected)
    end
  end

  describe '#highest_total_score' do
    it 'Highest point value game' do
      expect(stat.highest_total_score).to eq(7)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest point value game' do
      expect(stat.lowest_total_score).to eq(1)
    end
  end
end