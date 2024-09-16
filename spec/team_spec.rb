require 'spec_helper'

RSpec.describe 'team' do
  before(:each) do
    @team1 = Team.new('1','2','The Capybaras', 'CAP', "Wally\'s World", 'http:\\google.com')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team1).to be_an_instance_of(Team)
      expect(@team1.team_id).to eq('1')
      expect(@team1.franchise_id).to eq('2')
      expect(@team1.teamName).to eq('The Capybaras')
      expect(@team1.abbreviation).to eq("CAP")
      expect(@team1.stadium).to eq("Wally\'s World")
      expect(@team1.link).to eq("http:\\google.com")
    end
  end


end