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

  describe '#initialize' do
  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
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


  describe '#percentage_home_wins' do
    it 'calculates the percentage home wins ' do
      expect(@stat_tracker.percentage_home_wins).to eq(64.71)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns the percent of visitor wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(29.41)
    end
  end

end








end