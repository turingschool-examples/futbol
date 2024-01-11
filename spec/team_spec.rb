require 'spec_helper'

RSpec.describe Team do
   before(:each) do
      @teams = []
      CSV.foreach('data/teams_fixture.csv', headers: true, header_converters: :symbol) do |row|
         team_id = row[:team_id]
         team_name = row[:team_name]
         @teams << Team.new(team_id, team_name)
      end
      @teams
      @team = @teams[0]
   end

   describe 'Team' do
      it 'exists' do
         expect(@teams[0]).to be_a Team
      end

      it 'has a team id' do
         expect(@team.team_id).to eq(1)
      end

      it 'has a team name' do
         expect(@team.team_name).to eq("Atlanta United")
      end
   end
   
end