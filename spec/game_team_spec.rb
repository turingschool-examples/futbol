require 'spec_helper'

RSpec.describe GameTeam do
   before(:each) do
      @game_teams = []
      CSV.foreach('data/game_teams_fixture.csv', headers: true, header_converters: :symbol) do |row|
         game_team_details = {
            game_id: row[:game_id],
            team_id: row[:team_id],
            hoa: row[:hoa],
            result: row[:result],
            head_coach: row[:head_coach],
            goals: row[:goals],
            shots: row[:shots],
            tackles: row[:tackles]
         }
         @game_teams << GameTeam.new(game_team_details)
      end
      @game_teams
   end

   it 'exists' do
      expect(@game_teams[0]).to be_a GameTeam
   end
end