require 'rspec'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stat_tracker'

describe StatTracker do

  before(:all) do

    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe 'average_goals_per_game' do
    it 'calculates the average goals per game' do
      
    expect(@stat_tracker.average_goals_per_game).to eq(3.79)
    end
  end

  describe 'average_goals_per_season' do
    it 'calculates the average goals per season' do

    expect(@stat_tracker.average_goals_per_season["20122013"]).to eq(3.79)
    end
  end

  describe 'count_of_teams' do
    it 'calculates the total number of teams' do

    expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#highest_total_score' do
    it 'calculates the highest scoring game via total of both teams scores' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'calculates the lowest scoring game via total of both teams scores' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#best_offense' do
    it 'returns the name of the team with the highest average number of goals scored per game across all seasons' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end
  end

  describe '#worst_offense' do
    it 'returns the name of the team with the lowest average number of goals scored per game across all seasons' do
      expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
    end
  end

  describe '#winningest_coach' do
    it 'returns the name of the coach with the best win percentage for the season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end
  end
  
  describe '#worst_coach' do
    it 'returns the name of the coach with the worst win percentage for the season' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella, Dan Bylsma, Paul MacLean, Michel Therrien")
    end
  end
end