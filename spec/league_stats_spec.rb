require './spec/spec_helper'

describe LeagueStats do
  before do 
    teams_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'
    games_path = './data/games_sample.csv'
    @game_teams = GameTeams.create_game_teams(game_teams_path)
    @teams = Team.create_teams(teams_path)
    @games = Game.create_games(games_path)
  end

  let(:league_stat) { LeagueStats.new(@games, @game_teams, @teams) }

  describe '' do
    it 'exists' do
      expect(league_stat).to be_a(LeagueStats)
    end
  end

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(league_stat.count_of_teams).to eq(32)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(league_stat.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(league_stat.lowest_scoring_visitor).to eq("FC Cincinnati")
    end
  end

  describe '#highest_scoring_home_team' do
		it 'returns the NAME of the team who scored the most goals per game as the home team' do
			expect(league_stat.highest_scoring_home_team).to eq("Toronto FC")
		end
	end

  describe '#lowest_scoring_home_team' do
    it 'returns the NAME of the team who scored the most goals per game as the home team' do
      expect(league_stat.lowest_scoring_home_team).to eq("Atlanta United")
    end
  end

  describe '#best_offense' do
    it 'returns the team NAME with the MOST AVERAGE GOALS per game across ALL SEASONS' do
      expect(league_stat.best_offense).to eq("Toronto FC")
    end
  end

  describe '#worst_offense' do
    it 'returns the team NAME with the LEAST AVERAGE GOALS per game across ALL SEASONS' do
      expect(league_stat.worst_offense).to eq("DC United")
    end
  end

	context 'Helper Methods' do

		describe '#all_goals_by_away_team' do
			it 'returns all goals by away teams' do
				return_value = {
					1 => [2, 4, 2, 0],
					2 => [1, 1, 1],
					3 => [3, 0, 1, 1]
				}

				allow(league_stat).to receive(:scores_by_team).and_return(return_value)

				expected = {
					1 => 2.0,
					2 => 1.0,
					3 => 1.25
				}

				expect(league_stat.all_goals_by_away_team).to eq(expected)
			end
		end

		describe '#scores_by_home_team' do
			it 'returns all goals by home teams' do
				return_value = {
					1 => [2, 4, 2, 0],
					2 => [1, 1, 1],
					3 => [3, 0, 1, 1]
				}

				allow(league_stat).to receive(:scores_by_team).and_return(return_value)

				expected = {
					1 => 2.0,
					2 => 1.0,
					3 => 1.25
				}

				expect(league_stat.all_goals_by_home_team).to eq(expected)
			end
		end

		describe '#scores_by_team' do
			it 'returns a hash with keys as teams and values as goals scored in games' do
				expect(league_stat.scores_by_team(:home_team_id, :home_goals).keys).to include(Integer)
				expect(league_stat.scores_by_team(:home_team_id, :home_goals).values).to include(Array)
			end
		end

		describe '#sum_goals' do
			it 'returns a sum of goals when passing a hash of teams and goals' do
				goals_by_team = {
					1 => [2, 4, 2, 0],
					2 => [1, 1, 1],
					3 => [3, 0, 1, 1]
				}

				sum_of_goals_percentage = {
					1 => 2.0,
					2 => 1.0,
					3 => 1.25
				}				

				expect(league_stat.sum_goals(goals_by_team)).to eq(sum_of_goals_percentage)
			end
		end

		describe '#goals_per_game_by_team' do
			it 'returns a hash with teams as keys and goals as values' do
				expected = {
					1 => 2.0,
					10 => 2.25,
					12 => 3.0,
					13 => 2.0,
					14 => 1.0,
					15 => 2.0
				}

				expect(league_stat.goals_per_game_by_team).to include(expected)
			end
		end
	end
end
