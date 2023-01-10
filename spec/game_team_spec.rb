require_relative 'spec_helper'

RSpec.describe Game_team do
	before do
    location = './data/game_teams.csv'
		@game_teams = Game_team.all_game_teams(location)
	end
    let(:game_team){@game_teams[0]}

	describe '#initialize' do
		it 'exists' do
			expect(game_team).to be_a(Game_team)
		end

		it 'initializes with attributes' do
			expect(game_team.game_id).to eq("2012030221")
			expect(game_team.team_id).to eq("3")
			expect(game_team.hoa).to eq("away")
			expect(game_team.result).to eq("LOSS")
			expect(game_team.settled_in).to eq("OT")
			expect(game_team.head_coach).to eq("John Tortorella")
			expect(game_team.goals).to eq("2")
			expect(game_team.shots).to eq("8")
			expect(game_team.tackles).to eq("44")
			expect(game_team.pim).to eq("8")
			expect(game_team.power_play_opportunities).to eq("3")
			expect(game_team.power_play_goals).to eq("0")
			expect(game_team.face_off_win_percentage).to eq("44.8")
			expect(game_team.giveaways).to eq("17")			
			expect(game_team.takeaways).to eq("7")			
		end
	end
end