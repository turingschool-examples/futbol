require './lib/stat_tracker'

RSpec.describe StatTracker do
  context 'Iteration 1' do
    it 'exists' do
      stat_tracker = StatTracker.new

      expect(stat_tracker).to be_an_instance_of(StatTracker)
    end
  end
end
