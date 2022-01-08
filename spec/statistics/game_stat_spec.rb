require 'spec_helper'
require 'ostruct'
require './lib/statistics/game_statistics'

RSpec.describe GameStatistics do
  before(:each) do
    mock_game_1 = OpenStruct.new({ home_goals: 1, away_goals: 3, total_score: 4, home_win?: false, visitor_win?: true,
                                   tie?: false, season: '20122013' })
    mock_game_2 = OpenStruct.new({ home_goals: 2, away_goals: 6, total_score: 8, home_win?: false, visitor_win?: true,
                                   tie?: false, season: '20122013' })
    mock_game_3 = OpenStruct.new({ home_goals: 3, away_goals: 1, total_score: 4, home_win?: true, visitor_win?: false,
                                   tie?: false, season: '20122013' })
    mock_game_4 = OpenStruct.new({ home_goals: 2, away_goals: 2, total_score: 4, home_win?: false,
                                   visitor_win?: false, tie?: true, season: '20142015' })
    mock_game_manager = OpenStruct.new({ data: [mock_game_1, mock_game_2, mock_game_3, mock_game_4] })
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

  describe '#percentage_home_wins' do
    it 'has a percentage of home wins' do
      actual = @game_statistics.percentage_home_wins
      expected = 25
      expect(actual).to eq(expected)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'has a percentage of visitor wins' do
      actual = @game_statistics.percentage_visitor_wins
      expected = 50
      expect(actual).to eq(expected)
    end
  end

  describe '#percentage_ties' do
    it 'has a percentage of ties' do
      actual = @game_statistics.percentage_ties
      expected = 25
      expect(actual).to eq(expected)
    end
  end

  describe '#count_of_games_by_season' do
    it 'has a count of games per season' do
      actual = @game_statistics.count_of_games_by_season
      expected = { '20122013' => 3,
                   '20142015' => 1 }
      expect(actual).to eq(expected)
    end
  end

  describe '#average_goals_per_game' do
    it 'has an average of goals per game' do
      actual = @game_statistics.average_goals_per_game
      expected = 5
      expect(actual).to eq(expected)
    end
  end
end
