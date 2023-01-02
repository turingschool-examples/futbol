require_relative 'spec_helper'

describe StatTracker do
	before :each do
	@stat1 = StatTracker.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null")
	@stat2 = StatTracker.new(2012030222, 20122013, "Postseason", "5/19/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null")
	@stat3 = StatTracker.new(2012030223, 20122013, "Postseason", "5/21/13", 6, 3, 2, 1, "BBVA Stadium", "/api/v1/venues/null")
	end

	it 'exists' do
		expect(@stat1).to be_a StatTracker
		expect(@stat2).to be_a StatTracker
		expect(@stat3).to be_a StatTracker
	end

	it 'has an ID' do
		expect(@stat1.game_id).to eq(2012030221)
		expect(@stat2.game_id).to eq(2012030222)
		expect(@stat3.game_id).to eq(2012030223)
	end
end