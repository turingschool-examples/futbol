require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'League Statistics Class Tests'
require './lib/league_stats'

RSpec.describe LeagueStats do

  it "count_of_teams" do
    expect(count_of_teams).to eq(32)
  end

end