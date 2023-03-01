require 'rspec'
require 'spec_helper'

RSpec.describe League do
  describe '#initialize' do
    it 'initilaizes and has attributes' do
      league1 = League.new({
        team_id: 3,
        team_name: 'Blueberry Beagles',
        season: 20122013,
        type: 'Postseason',
        away_goals: 5,
        home_goals: 16,
        goals: 22
      })

      expect(league1).to be_a(League)
      expect(league1.team_id).to eq(3)
      expect(league1.team_name).to eq('Blueberry Beagles')
      expect(league1.season).to eq(20122013)
      expect(league1.type).to eq('Postseason')
      expect(league1.away_goals).to eq(5)
      expect(league1.home_goals).to eq(16)
      expect(league1.goals).to eq(22)
      expect(league1).to be_a(League)
    end
  end
end
