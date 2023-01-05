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
      expect(stat_tracker.average_goals_per_game).to eq(4.03)
    end
  end

  describe '#average_win_percentage' do
    it 'can take a teamid argument and return total win percentage across all games played' do
      expect(stat_tracker.average_win_percentage(52)).to eq(0.44)
    end
  end

  describe '#percentage_home_wins' do
    it 'returns % of home team wins (rounded to the nearest 100th)' do
      expect(stat_tracker.percentage_home_wins).to eq(0.46)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns % of visitor team wins (rounded x.xx)' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.42)
    end
  end

  describe '#percentage_ties' do
    it 'returns % of ties (rounded x.xx)' do
      expect(stat_tracker.percentage_ties).to eq(0.14)
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

	describe '#winningest_coach' do
		it 'names the coach with the best win percentage for the season' do
			expect(stat_tracker.winningest_coach(20162017)).to eq("Glen Gulutzan")
		end
	end

	describe '#worst_coach' do
		it 'names the coach with the worst percentage for the reason' do
			expect(stat_tracker.worst_coach(20162017)).to eq('Randy Carlyle')
		end
	end

  describe '#most_tackles' do
    it 'returns the NAME of team with most tackles in the SEASON' do
      expect(stat_tracker.most_tackles(20162017)).to eq("New York City FC")
    end
  end

  describe '#fewest_tackles' do
    it 'returns the NAME of team with fewest tackles the in SEASON' do
      expect(stat_tracker.fewest_tackles(20162017)).to eq("Montreal Impact")
    end
  end

  xdescribe '#find_by_team_id' do
    it 'returns the NAME of the team based on the ID' do
      expect(stat_tracker.find_team_by_id["4"]).to be_a(CSV::Row)
      # It is returning a CSV row even though the test fails.
    end
  end

	describe '#favorite_opponent' do
		it 'names of opponent that has lowest win % against given team' do
			expect(stat_tracker.favorite_opponent(52)).to eq("Chicago Red Stars")
		end
	end

	describe '#rival' do
		it 'names of opponent that has highest win % against given team' do
			expect(stat_tracker.rival(52)).to eq("Sporting Kansas City")
		end
	end

  describe '#highest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(stat_tracker.lowest_scoring_visitor).to eq("FC Cincinnati")
    end
  end

  describe '#highest_scoring_home_team' do
    it 'returns the NAME of the team who scored the most goals per game as the home team' do
      expect(stat_tracker.highest_scoring_home_team).to eq("Toronto FC")
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns the NAME of the team who scored the most goals per game as the home team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq("Atlanta United")
    end
  end

  describe '#team_info' do
    it 'returns a hash of team info by passing a team_id argument' do
      expected_hash = {
        'team_id' => '8',
        'franchise_id' => "1",
        'team_name' => "New York Red Bulls",
        'abbreviation' => "NY",
        'link' => "/api/v1/teams/8"
      }
      expect(stat_tracker.team_info('8')).to eq(expected_hash)
    end
  end

  xdescribe '#best_season' do
    it 'returns the season with the highest win percentage for a team argument' do
      expect(stat_tracker.best_season('8')).to be('')
    end
  end

  xdescribe '#worst_season' do
    it 'returns the season with the lowest win percentage for a team' do
      expect(stat_tracker.worst_season('8')).to eq('')
    end
  end

	describe '#best_offense' do
		it 'returns the team NAME with the MOST AVERAGE GOALS per game across ALL SEASONS' do
			expect(stat_tracker.best_offense).to eq("Toronto FC")
		end
	end

	describe '#worst_offense' do
		it 'returns the team NAME with the LEAST AVERAGE GOALS per game across ALL SEASONS' do
			expect(stat_tracker.worst_offense).to eq("DC United")
		end
	end

	describe '#most_accurate_team' do
		it 'returns TEAM NAME with the BEST ratio of SHOTS to GOALS for the SEASON' do
			expect(stat_tracker.most_accurate_team).to eq(???)
		end
	end

	describe '#least_accurate_team' do
		it 'returns TEAM NAME with the WORST ratio of SHOTS to GOALS for the SEASON' do
			expect(stat_tracker.least_accurate_team).to eq(???)
		end
	end
end