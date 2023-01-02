require_relative 'spec_helper'

describe StatTracker do
	before :each do
	@stat1 = StatTracker.new
	end

	it 'exists' do
		# require 'pry'; binding.pry
		expect(@stat1).to be_a StatTracker
		
	end

	it 'has can return IDs' do
		expect(@stat1.game_ids).to eq([2012030221, 2012030222, 2012030223])
	end
end