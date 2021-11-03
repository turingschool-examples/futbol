require 'csv'
require 'simplecov'
require './lib/league_stats'

SimpleCov.start

RSpec.describe LeagueStats do
  before :each do
    @league_path = './data/sample_game_teams.csv'

    @league_stats = LeagueStats.new(@league_path)
  end

  it 'exists' do

    expect(@league_stats).to be_an_instance_of(LeagueStats)
  end

  it '#count_of_teams' do

    expect(@league_stats.count_of_teams).to eq(5)
  end
end
