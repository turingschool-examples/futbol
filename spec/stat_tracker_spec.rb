require './lib/stat_tracker.rb'


  describe StatTracker do
  before :each do
    @stat_tracker = StatTracker.new
  end

  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end





end