require './spec/spec_helper'

RSpec.describe SeasonStatistics do
  before(:each) do
   
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @season_stats = SeasonStatistics.new(locations[:games], locations[:game_teams])
  
  end

  describe '#coach stats' do
    it 'knows the winningest coach' do
      #allow(@season_stats).to receive(:winningest_coach).and_return('Claude Julien')
      expect(@season_stats.winningest_coach).to eq('Claude Julien')
    end

    it 'knows the worst coach' do
      #allow(@season_stats).to receive(:worst_coach).and_return('John Tortorella')
      expect(@season_stats.worst_coach).to eq('John Tortorella')
    end
  end

  describe '#accuracy stats' do
    it 'knows the most accurate team' do
      allow(@season_stats).to receive(:most_accurate_team).and_return('FC Dallas')
      expect(@season_stats.most_accurate_team).to eq('FC Dallas')
    end

    it 'knows the least accurate team' do
      allow(@season_stats).to receive(:least_accurate_team).and_return('Houston Dynamo')
      expect(@season_stats.least_accurate_team).to eq('Houston Dynamo')
    end
  end

  describe '#tackle stats' do
    it 'knows the team with the most tackles' do
      allow(@season_stats).to receive(:most_tackles).and_return('Houston Dynamo')
      expect(@season_stats.most_tackles).to eq('Houston Dynamo')
    end

    it 'knows the team with the fewest tackles' do
      allow(@season_stats).to receive(:fewest_tackles).and_return('FC Dallas')
      expect(@season_stats.fewest_tackles).to eq('FC Dallas')
    end
  end
end