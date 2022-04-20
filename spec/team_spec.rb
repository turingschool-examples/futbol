describe Team do
	before :each do
		@team1 = Team.new({team_id: '1', franchiseid: '23', teamname: 'Atlanta United', abbreviation: 'ATL', stadium: 'Mercedes-Benz Stadium', link: '/api/v1/teams/1'})
	end

	it "exists" do
		expect(@team1).to be_a Team
	end

	it "has attributes" do
		expect(@team1.team_id).to eq(1)
		expect(@team1.franchise_id).to eq('23')
		expect(@team1.team_name).to eq('Atlanta United')
		expect(@team1.abbreviation).to eq('ATL')
		expect(@team1.stadium).to eq('Mercedes-Benz Stadium')
		expect(@team1.link).to eq('/api/v1/teams/1')
	end


end
