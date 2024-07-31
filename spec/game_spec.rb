require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe Game do
  before(:each) do
    game_path = './data/games.csv'

    @game_data = {
      :game_id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :date_time => "5/16/13",
      :away_team_id => "3",
      :home_team_id => "6",
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
    }

    @game = Game.new(@game_data)

  end
    it 'exists' do
        expect(@game).to be_a Game
    end
# create variables of the games stuff below
# 2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
# 2012030222,20122013,Postseason,5/19/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null

end