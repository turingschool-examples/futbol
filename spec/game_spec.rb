require_relative 'spec_helper'
require './lib/game'

RSpec.describe Game do
  before(:each) do
    @base_row = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  describe '#total_score' do
    it 'adds home and away goals to calculate total' do
      @base_row[6] = 2
      @base_row[7] = 1
      actual = Game.new(@base_row).total_score
      expected = 3
      expect(actual).to eq(expected)
    end
  end
end
