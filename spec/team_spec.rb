require 'spec_helper'

RSpec.describe Team do
   before(:each) do
      @teams = []
      CSV.foreach('data/teams_fixture.csv', headers: true, header_converters: :symbol) do |row|
         team_id = row[:id]
         team_name = row[:teamName]
         @teams << Team.new(team_id, team_name)
      end
      @teams
   end

   it 'exists' do
      expect(@teams[0]).to be_a Team
   end
end