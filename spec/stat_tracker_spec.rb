require 'rspec'
require './lib/stat_tracker'
require 'csv'

RSpec.describe StatTracker do

    it '1. exists' do
        stat_tracker = StatTracker.new
        expect(stat_tracker).to be_an_instance_of(StatTracker)
    end

    xit '2. has the data paths for the csv files' do
        stat_tracker = StatTracker.new

    end
    

end
