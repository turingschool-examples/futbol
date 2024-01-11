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
      @game_team_first = @game_teams[0]
      @game_team_last = @game_teams[-1]
   end

   it 'exists' do
      expect(@game_team_first).to be_a GameTeam
      expect(@game_team_last).to be_a GameTeam
   end

   it 'has a game_id' do
      expect(@game_team_first.game_id).to eq("2012030221")
      expect(@game_team_last.game_id).to eq("2012030231")
   end

   it 'has a team_id' do
      expect(@game_team_first.team_id).to eq(3)
      expect(@game_team_last.team_id).to eq(16)
   end

   it 'has a hoa' do
      expect(@game_team_first.hoa).to eq("away")
      expect(@game_team_last.hoa).to eq("home")
   end

   it 'has a result' do
      expect(@game_team_first.result).to eq("LOSS")
      expect(@game_team_last.result).to eq("WIN")
   end

   it 'has a head_coach' do
      expect(@game_team_first.head_coach).to eq("John Tortorella")
      expect(@game_team_last.head_coach).to eq("Joel Quenneville")
   end
   it 'has goals' do
      expect(@game_team_first.goals).to eq(2)
      expect(@game_team_last.goals).to eq(2)
   end

   it 'has shots' do
      expect(@game_team_first.shots).to eq(8)
      expect(@game_team_last.shots).to eq(10)
   end
   
   it 'has tackles' do
      expect(@game_team_first.tackles).to eq(44)
      expect(@game_team_last.tackles).to eq(24)
   end
   
end