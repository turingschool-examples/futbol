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
      @game_team_0 = @game_teams[0]
   end

   it 'exists' do
      expect(@game_teams[0]).to be_a GameTeam
      expect(@game_team_0.game_id).to eq("2012030221")
      expect(@game_team_0.team_id).to eq("3")
      expect(@game_team_0.hoa).to eq("away")
      expect(@game_team_0.result).to eq("LOSS")
      expect(@game_team_0.head_coach).to eq("John Tortorella")
      expect(@game_team_0.goals).to eq("2")
      expect(@game_team_0.shots).to eq("8")
      expect(@game_team_0.tackles).to eq("44")
   end
end