require_relative './spec_helper'

describe Helper do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)

    @test_teams = @stat_tracker.teams[0..3]
    @test_game_teams = @stat_tracker.game_teams[0..3]
    @game_1 = double('game 1')
    @game_2 = double('game 2')
    allow(@game_1).to receive(:away_goals).and_return(2)
    allow(@game_1).to receive(:home_goals).and_return(4)
    allow(@game_2).to receive(:away_goals).and_return(10)
    allow(@game_2).to receive(:home_goals).and_return(6)
    allow(@game_1).to receive(:goals).and_return(6)
    allow(@game_2).to receive(:goals).and_return(10)
  end

  describe 'helpers' do
    it 'can return the sum of home and away goals' do
      expect(@stat_tracker.total_goals(@game_1)).to eq(6)
    end

    it 'can return the total count of games' do
      expect(@stat_tracker.total_games([@game_1, @game_2])).to eq(2)
    end

    it 'can return the total count of teams' do
      expect(@stat_tracker.total_teams(@test_teams)).to eq(4)
    end

    it 'can return average home and away goals' do
      expect(@stat_tracker.average_away_goals([@game_1, @game_2])).to eq(6)
      expect(@stat_tracker.average_home_goals([@game_1, @game_2])).to eq(5)
    end

    it 'can return average goals overall' do
      expect(@stat_tracker.average_of_goals([@game_1, @game_2])).to eq(8)
    end

    it 'can return the average accuracy for a set of games' do
      expect(@stat_tracker.average_accuracy(@test_game_teams)).to eq(27.03)
    end

    it 'can return the share of wins across a given set of games' do
      expect(@stat_tracker.percent_win_loss(@test_game_teams)).to eq(0.50)
    end
  end
end
