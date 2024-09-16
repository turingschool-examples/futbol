require 'spec_helper'

RSpec.describe 'team' do
  before(:each) do
    @team1 = Team.new(1,2,'The Capybaras', 'CAP', "Wally\'s World", 'http:\\google.com')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team1).to be_an_instance_of(Team)
    end
  end
end