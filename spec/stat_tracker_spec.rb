require_relative 'simplecov'
require_relative './lib/stat_tracker'


SimpleCov.start
RSpec.describe StatTracker do

  it 'exists' do
    stat_tracker = StatTracker.new([], [], [])

    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'can access instance variables' do
    stat_tracker = StatTracker.new(['a'], ['b'], ['c'])


    expect(stat_tracker.games).to eq(['a'])
    expect(stat_tracker.teams).to eq(['b'])
    expect(stat_tracker.game_teams).to eq(['c'])
  end
end
