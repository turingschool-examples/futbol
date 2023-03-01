require 'spec_helper'

RSpec.describe Games do
  before(:each) do
    @games = Games.new({
      game_id: '2012030221',
      season: '20122013',
      type: 'Postseason',
      away_team_id: '3',
      home_team_id: '6',
      home_goals: '3',
      away_goals: '2'
    })
  end
  describe '#initializes' do
    it 'exists' do
      expect(@games).to be_a(Games)
    end

    it 'has attributes' do
      expect(@games.game_id).to eq('2012030221')
      expect(@games.season_year).to eq('20122013')
      expect(@games.season_type).to eq('Postseason')
      expect(@games.away_team_id).to eq('3')
      expect(@games.home_team_id).to eq('6')
      expect(@games.home_goals).to eq('3')
      expect(@games.away_goals).to eq('2')
      expect(@games.total_score).to eq(5)
    end
  end
end