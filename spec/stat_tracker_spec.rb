require 'spec_helper'
RSpec.describe StatTracker do
  let(:teams) { './data/teams.csv' } 
  let(:stat_tracker) { StatTracker.from_csv(teams) } 

  describe "::from_csv" do 
    it 'will create a new instance object using data from the given csv' do
      expect(stat_tracker).to be_a(StatTracker)
      expect(stat_tracker.contents).to eq(teams)
    end
  end
end 