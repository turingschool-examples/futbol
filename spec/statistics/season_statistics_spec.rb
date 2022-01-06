# frozen_string_literal: true
require 'RSpec'
require './spec/spec_helper'
require 'ostruct'
require './lib/statistics/season_statistics'
require 'pry'

RSpec.describe SeasonStatistics do
  before(:each) do
    mock_season_1 = OpenStruct.new({ game_id: 2012030221, team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7 })
    mock_season_2 = OpenStruct.new({ game_id: 2012030221, team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5 })
    mock_season_3 = OpenStruct.new({ game_id: 2012030222, team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4 })

    mock_game_team_manager = OpenStruct.new({ data: [mock_season_1, mock_season_2, mock_season_3] })
    @game_statistics = SeasonStatistics.new(mock_game_team_manager)
  end
  it 'will create an instance of SeasonStatistics' do
    expect(@game_statistics).to be_instance_of(SeasonStatistics)
  end
end
