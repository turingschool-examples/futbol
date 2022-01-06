require 'spec_helper'
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

  describe '#home_win?' do
    it 'can determine if it is not a home win' do
      @base_row[6] = 4
      @base_row[7] = 2
      actual = Game.new(@base_row).home_win?
      expected = false
      expect(actual).to eq(expected)
    end

    it 'can determine if it is a home win' do
      @base_row[6] = 1
      @base_row[7] = 2
      actual = Game.new(@base_row).home_win?
      expected = true
      expect(actual).to eq(expected)
    end

    it 'does not consider ties a home win' do
      @base_row[6] = 2
      @base_row[7] = 2
      actual = Game.new(@base_row).home_win?
      expected = false
      expect(actual).to eq(expected)
    end
  end
end
