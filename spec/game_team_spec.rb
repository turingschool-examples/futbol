require spec_helper

RSpec.describe Game_team do
	let(:game_team_row1){ Game_team.new("2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7") }

	describe '#initialize' do
		it 'exists' do
			expect(game_team_row1).to be_instance_of(Game_team)
		end
	end
end