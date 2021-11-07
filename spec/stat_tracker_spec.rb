require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './runner'

describe StatTracker do
  before(:each) do

    game_path = './data/games_tester.csv'
    team_path = './data/teams_tester.csv'
    game_teams_path = './data/game_teams_tester.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end
  end

  describe '#count of teams' do
    it 'returns total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq(10)
    end


    it 'returns an integer' do
      expect(@stat_tracker.count_of_teams).to be_instance_of(Integer)
    end
  end

  describe '#best_offense' do
    it 'returns team with most avg goals per game for all seasons' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.best_offense).to be_instance_of(String)
    end
  end

  describe '#games_by_team' do
    it 'returns number of games per team by team_id' do
      expect(@stat_tracker.games_by_team(3).length).to eq(5)
    end
  end

  describe '#total goals_by_team' do
    it 'returns number of total goals by team_id' do
      expect(@stat_tracker.total_goals_by_team(3)).to eq(8)
    end
  end

  describe '#average_goals_per_game' do
    it 'returns number of average goals per game by team_id' do
      expect(@stat_tracker.average_goals_per_game(3)).to eq(1.6)
    end
  end

  describe '#worst_offense' do
    it 'returns team with least avg goals per game for all seasons' do
      expect(@stat_tracker.worst_offense).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.worst_offense).to be_instance_of(String)
    end
  end

  describe '#games_away' do
    it 'returns all away games by team_id' do
      expect(@stat_tracker.games_away(3).length).to eq(3)
    end
  end

  describe '#average_away_score' do
    it 'returns average score per away game by team_id' do
      expect(@stat_tracker.average_away_score(3)).to eq(1.7)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns team with highest avg score for away games' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end


    it 'returns a string' do
      expect(@stat_tracker.highest_scoring_visitor).to be_instance_of(String)
    end
  end

  describe '#highest_scoring_home_team' do
    it 'returns team with highest avg score for home games' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.highest_scoring_home_team).to be_instance_of(String)
    end
  end

  describe '#games_home' do
    it 'returns all home games by team_id' do
      expect(@stat_tracker.games_home(3).length).to eq(2)
    end
  end

  describe '#average_home_score' do
    it 'returns average score per home game by team_id' do
      expect(@stat_tracker.average_home_score(3)).to eq(1.5)
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns team with lowest avg score for away games' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.lowest_scoring_visitor).to be_instance_of(String)
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns team with lowest avg score for home games' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.lowest_scoring_home_team).to be_instance_of(String)
    end
  end 

end
