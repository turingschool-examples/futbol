# frozen_string_literal: true
require 'RSpec'
require './spec/spec_helper'
require 'ostruct'
require './lib/statistics/season_statistics'
require 'pry'

RSpec.describe SeasonStatistics do
  before(:each) do
    @mock_season_1 = OpenStruct.new({ game_id: 2012030221, team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7 })
    @mock_season_2 = OpenStruct.new({ game_id: 2012030221, team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5 })
    @mock_season_3 = OpenStruct.new({ game_id: 2012030222, team_id: 3, HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4 })
    @mock_season_4 = OpenStruct.new({ game_id: 2015030241, team_id: 18, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'Peter Laviolette', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })

    mock_game_team_manager = OpenStruct.new({ data: [@mock_season_1, @mock_season_2, @mock_season_3, @mock_season_4] })
    @game_statistics = SeasonStatistics.new(mock_game_team_manager)
  end
  it 'will create an instance of SeasonStatistics' do
    expect(@game_statistics).to be_instance_of(SeasonStatistics)
  end

  it 'will find the coaches of a certain season' do
    expect(@game_statistics.season_coaches(2012030221)).to eq(['John Tortorella', 'Claude Julien'])
  end

  it 'will find all the games in a season, given a season' do
    expect(@game_statistics.game_teams_data_by_season(2015030241)).to eq([@mock_season_4])
  end

  it 'will calculate the win percentage of a coach' do
    expect(@game_statistics.coaches_by_win_percentage(2012030221, 'Claude Julien')).to eq(100.0)
  end

  it 'will find the coach that has the best record in a season' do
    expect(@game_statistics.winningest_coach(2012030221)).to eq('Claude Julien')
  end

  it 'will find the coach that has the worst record in a season' do
    expect(@game_statistics.worst_coach(2012030222)).to eq('John Tortorella')
  end

  # Aedan's tests
  describe '#matching_teams' do
    it 'can return an array of game objects that match a team_id' do
      actual = @game_statistics.matching_teams(3)
      expected = [@mock_season_1, @mock_season_3]
      expect(actual).to eq(expected)
    end
  end

  describe '#total_games' do
    it 'can return the total number of games for a given team' do
      actual = @game_statistics.total_games(3)
      expected = 2
      expect(actual).to eq(expected)
    end
  end

  describe '#win_percentage' do
    it 'can return the win percentage of all games for a given team' do
        actual = @game_statistics.win_percentage(3)
        expected = 50
        expect(actual).to eq(expected)
    end
  end
end
