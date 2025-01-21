require './spec/spec_helper'


describe Team do
    before :each do
        @team = Team.new(1, 23, "Atlanta United", "ATL", "Mercedes-Benz Stadium", "/api/v1/teams/1")
    end

    describe '#initialize' do
        it 'exists' do
            expect(@team).to be_a Team
        end
    end
end