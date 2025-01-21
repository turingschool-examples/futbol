require './spec/spec_helper'

describe League_Statistics do
  before :all do
    League_Statistics.set_leagueCSV('./data/teams.csv', './data/games.csv', './data/game_teams.csv')
  end
  describe '#count_of_teams' do
    it 'can count teams' do
      expect(League_Statistics.count_of_teams).to eq(32)
    end
  end

  describe '#best_offense' do
    it 'can return team with highest average goals' do
      expect(League_Statistics.best_offense).to eq("Reign FC")
    end
  end

  describe '#worst_by' do
    it 'can return the team with the lowest average goals' do
      expect(League_Statistics.worst_offense).to eq("Utah Royals FC")
    end
  end

  describe '#games_played' do
    it 'can return amount of games played by team id' do
      expect(League_Statistics.games_played(1)).to eq(463)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'can return highest scoring visitor' do
      expect(League_Statistics.highest_scoring_visitor).to eq('FC Dallas')
    end
  end

  describe '#highest_scoring_home_team' do
    it 'can return highest scoring home team' do
      expect(League_Statistics.highest_scoring_home_team).to eq('Reign FC')
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'can return the lowest scoring visiting team' do
      expect(League_Statistics.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'can return the lowest scoring home team' do
      expect(League_Statistics.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end
end