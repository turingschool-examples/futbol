require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Game do
  before(:each) do

    hash = {:game_id => 2012030221,
            :sesason => 20122013,
            :type => "Postseason",
            :date_time => 5/16/13,
            :away_team_id => 3,
            :home_team_id => 6,
            :away_goals => 2,
            :home_goals => 3,
            :venue => "Toyota Stadium",
            :venue_link => /api/v1/venues/null}

            @game = Game.new(hash)
  end



