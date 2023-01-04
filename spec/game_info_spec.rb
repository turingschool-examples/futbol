require './lib/game_info'

RSpec.describe GameInfo do
  let(:game_info) do 
    GameInfo.new ({
      :game_id => 2012030221,
      :season => 20122013,
      :type => "Postseason",
      :date_time => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Statdium",
      :venue_link => "/api/v1/venues/null"
    })
  end
  describe '#initialize' do
    it 'exists' do
      expect(gameinfo).to be_an_instance_of(GameInfo)
    end
  end
end