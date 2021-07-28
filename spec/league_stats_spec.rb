require 'rspec'
require './lib/game_stats'
require './lib/stat_tracker'
require './lib/games'
require './lib/league_stats'

RSpec.describe LeagueStats do
  before(:each) do
    game_file = Games.file('./data/games.csv')
    @league_stats = LeagueStats.new(game_file)
  end

  it 'exists' do
    expect(@league_stats).to be_a(LeagueStats)
  end

  it 'gives count of teams' do
    expect(@league_stats.count_of_teams).to be_a(Integer)
  end

  it 'gives best offense' do
    expect(@league_stats.best_offense).to be_a(String)
  end

  it 'gives worst offense' do
    expect(@league_stats.worst_offense).to be_a(String)
  end

  it 'gives highest scoring visitor' do
    expect(@league_stats.highest_scoring_visitor).to be_a(String)
  end

  it 'gives highest scoring home team' do
    expect(@league_stats.highest_scoring_home_team).to be_a(String)
  end

  it 'gives lowest scoring visitor' do
    expect(@league_stats.lowest_scoring_visitor).to be_a(String)
  end

  it 'gives lowest_scoring home team' do
    expect(@league_stats.lowest_scoring_home_team).to be_a(String)
  end
end
