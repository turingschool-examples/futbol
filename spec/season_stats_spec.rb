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

  context 'Helper Methods' do
    describe '#season_team_tackles' do
      it 'returns a hash with keys of teams and values of total tackles over that season' do
        allow(stat).to receive(:tackles_by_team_id).and_return ({20=>[13, 16], 24=>[15, 25], 22=>[16], 23=>[13]})
        expect(stat.season_team_tackles(20132014)).to eq({20=>29, 24=>40, 22=>16, 23=>13})
      end
    end

    describe '#tackles_by_team_id' do
      it 'returns a hash with team_ids as keys and values of tackles in each game played' do
        game_ids = [2016021174, 2016021218, 2016020499, 2016020056]
        expect(stat.tackles_by_team_id(game_ids)).to eq(
          {20=>[13], 24=>[15, 25], 22=>[16], 23=>[13], 9=>[29], 13=>[14], 15=>[17]})
      end
    end

    describe '#coach_game_results_by_game' do
      it 'returns a hash with keys of coaches and values of game results' do
        game_ids = [2016021174, 2016021218, 2016020499, 2016020056]
        expect(stat.coach_game_results_by_game(game_ids)).to eq(
          {"Barry Trotz"=>["TIE"], "Gerard Gallant"=>["TIE"], "Glen Gulutzan"=>["WIN"], 
          "Guy Boucher"=>["WIN"], "Randy Carlyle"=>["LOSS", "LOSS"], "Todd McLellan"=>["WIN"],
           "Willie Desjardins"=>["LOSS"]})
      end
    end

    describe '#accuracy_by_team' do
      it 'returns a hash with team_ids as keys and shots/goal ratio as values' do
        game_ids = [2016021174, 2016021218, 2016020499, 2016020056]
        expect(stat.accuracy_by_team(game_ids)).to eq(
          {20=>0.6, 24=>0.21428571428571427, 22=>0.375, 23=>0.2857142857142857, 9=>0.5, 
          13=>0.2857142857142857, 15=>0.2857142857142857})
      end
    end

    describe '#win_percentage_by_coach' do
      it 'returns a hash' do
        allow(stat).to receive(:game_ids_for_season).and_return([2016021174, 2016021218, 2016020499, 2016020056])
        expect(stat.win_percentage_by_coach(20142015)).to eq(
          {"Barry Trotz"=>0.0, "Gerard Gallant"=>0.0, "Glen Gulutzan"=>1.0, "Guy Boucher"=>1.0, 
          "Randy Carlyle"=>0.0, "Todd McLellan"=>1.0, "Willie Desjardins"=>0.0})
      end

    end
  end
end