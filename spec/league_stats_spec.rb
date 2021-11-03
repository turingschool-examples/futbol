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

  it '#best_offense' do

    expect(@league_stats.best_offense).to eq("17")
  end

  it '#worst_offense' do

    expect(@league_stats.worst_offense).to eq("5")
  end

  it '#highest_scoring_visitor' do

    expect(@league_stats.highest_scoring_visitor).to eq("6")
  end
end
