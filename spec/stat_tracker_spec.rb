require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec StatTracker do
  before(:each) do
    @stat_tracker = StatTracker.new
  end

  descibe '#initialize' do
    it 'exists' do

    end
  end
end