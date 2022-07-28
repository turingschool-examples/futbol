require './lib/stat_tracker'
require './lib/game'

RSpec.describe StatTracker do
  it 'exits' do
    locations = {
      games: './fixtures/fixture_data_game_statistics/games.csv' 
    } 
    stat_tracker = StatTracker.new(locations)

    expect(stat_tracker).to be_instance_of(StatTracker)
    expect(stat_tracker.games).to all be_instance_of(Game)
  end 
end 
