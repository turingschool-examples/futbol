# frozen_string_literal: true
require 'RSpec'
require './spec/spec_helper'
require 'ostruct'
require './lib/statistics/season_statistics'
require 'pry'

RSpec.describe SeasonStatistics do
  before(:each) do
    @mock_season_1 = OpenStruct.new({ game_id: '2001000001', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7 })
    @mock_season_2 = OpenStruct.new({ game_id: '2001000002', team_id: '6', HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Peter Laviolette', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5 })
    @mock_season_3 = OpenStruct.new({ game_id: '2001000003', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4 })
    @mock_season_4 = OpenStruct.new({ game_id: '2001000004', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })
    @mock_season_5 = OpenStruct.new({ game_id: '2002000001', team_id: '6', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'Peter Laviolette', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })
    @mock_season_6 = OpenStruct.new({ game_id: '2002000002', team_id: '6', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'Peter Laviolette', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })
    @mock_season_7 = OpenStruct.new({ game_id: '2002000003', team_id: '6', HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'Peter Laviolette', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })
    @mock_season_8 = OpenStruct.new({ game_id: '2002000004', team_id: '6', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'Peter Laviolette', goals: 2, shots: 7, tackles: 32, pim: 24, powerPlayOpportunities: 2, powerPlayGoals: 1, faceOffWinPercentage: 46, giveaways: 13, takeaways: 46 })

    mock_game_team_manager = OpenStruct.new({ data: [@mock_season_1, @mock_season_2, @mock_season_3, @mock_season_4, @mock_season_5, @mock_season_6, @mock_season_7, @mock_season_8] })
    @season_statistics = SeasonStatistics.new(mock_game_team_manager)
  end
  it 'will create an instance of SeasonStatistics' do
    expect(@season_statistics).to be_instance_of(SeasonStatistics)
  end

  it 'will find the coaches of a certain season' do
    expect(@season_statistics.season_coaches('2001000001')).to eq(['John Tortorella', 'Peter Laviolette'])
    expect(@season_statistics.season_coaches('2002000001')).to eq(['Peter Laviolette'])
  end

  it 'will find all the games in a season, given a season' do
    expect(@season_statistics.game_teams_data_by_season('2001000001')).to eq([@mock_season_1, @mock_season_2, @mock_season_3, @mock_season_4])
  end

  it 'will calculate the win percentage of a coach for a given season' do
    expect(@season_statistics.coaches_by_win_percentage('2002000003', 'Peter Laviolette')).to eq(25.00)
  end

  it 'will find the coach that has the best record in a season' do
    expect(@season_statistics.winningest_coach('2001000001')).to eq('Peter Laviolette')
  end

  it 'will find the coach that has the worst record in a season' do
    expect(@season_statistics.worst_coach('2001000001')).to eq('John Tortorella')
  end
  describe 'Accuracy' do
    it 'will return the most accurate team in a season' do
    end

    it 'will return the least accurate team in a season' do
    end
  end

  describe 'Tackles' do
    it 'will find the team_id with the most tackles in a season' do
      expect(@season_statistics.most_tackles('2001000001')).to eq('3')
    end

    it 'will find the team with the least tackles in a season' do
      expect(@season_statistics.most_tackles('2002000004')).to eq('6')
    end
  end
  it 'will find all the teams that play in a season' do
    expect(@season_statistics.season_teams('2001000001')).to eq(['3', '6'])
  end

  it 'will return the tackles by team in a season' do
    expect(@season_statistics.tackles_by_team('2001000001', '3')).to eq(109)

  end

  it 'will return the accuracy of a certain team in percentage form' do
    expect(@season_statistics.teams_by_accuracy('2002000004', '6')).to eq(28.57)
  end

  # Aedan's tests
  describe '#matching_teams' do
    it 'can return an array of game objects that match a team_id' do
      actual = @season_statistics.matching_teams(3)
      expected = [@mock_season_1, @mock_season_3, @mock_season_4]
      expect(actual).to eq(expected)
    end
  end

  describe '#total_games' do
    it 'can return the total number of games for a given team' do
      actual = @season_statistics.total_games(3)
      expected = 3
      expect(actual).to eq(expected)
    end
  end

  describe '#win_percentage' do
    it 'can return the win percentage of all games for a given team' do
        actual = @season_statistics.win_percentage(6)
        expected = 40.0
        expect(actual).to eq(expected)
    end
  end

  describe '#most_goals_scored' do
    it 'can return the win percentage of all games for a given team' do
        actual = @season_statistics.most_goals_scored(6)
        expected = 3
        expect(actual).to eq(expected)
    end
  end

  describe '#fewest_goals_scored' do
    it 'can return the win percentage of all games for a given team' do
        actual = @season_statistics.fewest_goals_scored(6)
        expected =2
        expect(actual).to eq(expected)
    end
  end
end
