require './lib/modules'
require './lib/stat_tracker'

describe Sortable do
	describe '#games_played_by_season' do
		it 'returns a hash with season as keys and games associated to season as values' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")
			game2 = double("Game 2")

			allow(game1).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none'})
			allow(game2).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none'})

			allow(stat_tracker).to receive(:games).and_return([game1, game2])
			expect(stat_tracker.games_played_by_season).to eq({20132014=>[game1, game2]})
		end
	end

	describe '#games_by_game_id' do
		it 'returns a hash with games as keys and game ids associated to game as values' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")
			game2 = double("Game 2")

			allow(game1).to receive(:info).and_return({game_id: 20193845})
			allow(game2).to receive(:info).and_return({game_id: 20193846})

			allow(stat_tracker).to receive(:game_teams).and_return([game1, game2])
			expect(stat_tracker.games_by_game_id).to eq({20193845=>[game1], 20193846=>[game2]})
		end
	end

	describe '#games_by_team_id' do
		it 'returns a hash with team as keys and games associated to team as values' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")
			game2 = double("Game 2")

			allow(game1).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none', team_id: 20345})
			allow(game2).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none', team_id: 20111})

			allow(stat_tracker).to receive(:game_teams).and_return([game1, game2])
			expect(stat_tracker.games_by_team_id).to eq({20345=>[game1], 20111 => [game2]})
		end
	end

	describe '#find_team_by_id' do
		it 'returns the team as value associated to team_id as a key' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")
			game2 = double("Game 2")

			allow(game1).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none', team_id: 20345})
			allow(game2).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none', team_id: 20111})

			allow(stat_tracker).to receive(:teams).and_return([game1, game2])
			expect(stat_tracker.find_team_by_id).to eq({20345=>[game1], 20111 => [game2]})
		end
	end

	describe '#team_name_by_id' do
		it 'returns name of the team when given an id' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")

			allow(game1).to receive(:info).and_return({game_id: 20193845, season: 20132014, team_name: 'LA Galaxy', team_id: 20345})

			allow(stat_tracker).to receive(:find_team_by_id).and_return({20193845=>[game1]})
			expect(stat_tracker.team_name_by_id(20193845)).to eq('LA Galaxy')
		end
	end

	describe '#game_ids_for_season' do
		it 'returns a hash with season as keys and games associated to season as values' do
			stat_tracker = double('StatTracker')
			stat_tracker.extend(Sortable)

			game1 = double("Game 1")
			game2 = double("Game 2")

			allow(game1).to receive(:info).and_return({game_id: 20193845, season: 20132014, venue: 'none', team_id: 20345})
			allow(game2).to receive(:info).and_return({game_id: 20193846, season: 20132014, venue: 'none', team_id: 20111})

			allow(stat_tracker).to receive(:games_played_by_season).and_return({20132014=>[game1, game2]})
			expect(stat_tracker.game_ids_for_season(20132014)).to eq([20193845, 20193846])
		end
	end
end