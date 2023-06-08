require './lib/stat_tracker'
require './lib/game_factory'
require "csv"


RSpec.describe 'Game' do
  

  let(:stat_tracker) { StatTracker.new }

  before do 
    stat_tracker.from_csv(path)
  end

  it 'can determine percentage home wins' do

    # expect(game.percentage_visitor_wins).to be_a(Float)

  end

end