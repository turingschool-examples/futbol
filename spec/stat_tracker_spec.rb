require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    @stat_tracker = StatTracker.new
    @game_path = double('game_path')
    allow(@game_path).to receive(:games).and_return(games_test_data)
  end
  describe '#Percentage_home_wins' do
    it 'checks the percentage of home wins' do
      # require 'pry'; binding.pry
      expect().to eq()
    end
  end





  def games_test_data
    [{:game_id=>"2012030221",
      :season=>"20122013",
      :type=>"Postseason",
      :date_time=>"5/16/13",
      :away_team_id=>"3",
      :home_team_id=>"6",
      :away_goals=>"2",
      :home_goals=>"3",
      :venue=>"Toyota Stadium",
      :venue_link=>"/api/v1/venues/null"},
    {:game_id=>"2012030222",
      :season=>"20122013",
      :type=>"Postseason",
      :date_time=>"5/19/13",
      :away_team_id=>"3",
      :home_team_id=>"6",
      :away_goals=>"2",
      :home_goals=>"3",
      :venue=>"Toyota Stadium",
      :venue_link=>"/api/v1/venues/null"},
    {:game_id=>"2012030223",
      :season=>"20122013",
      :type=>"Postseason",
      :date_time=>"5/21/13",
      :away_team_id=>"6",
      :home_team_id=>"3",
      :away_goals=>"2",
      :home_goals=>"1",
      :venue=>"Toyota Stadium",
      :venue_link=>"/api/v1/venues/null"},
    {:game_id=>"2012030224",
      :season=>"20122013",
      :type=>"Postseason",
      :date_time=>"5/23/13",
      :away_team_id=>"6",
      :home_team_id=>"3",
      :away_goals=>"3",
      :home_goals=>"2",
      :venue=>"Toyota Stadium",
      :venue_link=>"/api/v1/venues/null"}]
  end
end