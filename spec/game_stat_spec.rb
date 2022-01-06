require_relative 'spec_helper'
require 'ostruct'
require './lib/game_statistics'

RSpec.describe GameStatistics do
  before(:each) do
    mock_game_1 = OpenStruct.new({ home_score: 1, away_score: 3, total_score: 4 })
    mock_game_2 = OpenStruct.new({ home_score: 2, away_score: 6, total_score: 8 })
    mock_game_manager = OpenStruct.new({ data: [mock_game_1, mock_game_2] })
    @game_statistics = GameStatistics.new(mock_game_manager)
  end
  describe '#highest_total_score' do
    it 'has a highest winning score' do
      actual = @game_statistics.highest_total_score
      expected = 8
      expect(actual).to eq(expected)
    end
  end

  describe '#lowest_total_score' do
    it 'has a lowest score' do
      actual = @game_statistics.lowest_total_score
      expected = 4
      expect(actual).to eq(expected)
    end
  end
end
