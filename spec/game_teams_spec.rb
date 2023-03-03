require 'spec_helper'

RSpec.describe GameTeams do
  before(:each) do
    @game_teams = GameTeams.new({
      head_coach: 'John Hynes',
      goals: '2',
      shots: '7',
      tackles: '36',
      team_id: '1',
      game_id: '2017030111',
      result: 'LOSS',
      hoa: 'away'
    })
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game_teams).to be_a(GameTeams)
    end

    it 'has attributes' do
      expect(@game_teams.coach).to eq('John Hynes')
      expect(@game_teams.goals).to eq('2')
      expect(@game_teams.shots).to eq('7')
      expect(@game_teams.tackles).to eq('36')
      expect(@game_teams.team_id).to eq('1')
      expect(@game_teams.game_id).to eq('2017030111')
      expect(@game_teams.season_id).to eq('20172018')
      expect(@game_teams.result).to eq('LOSS')
      expect(@game_teams.home_away).to eq('away')
    end
  end
end