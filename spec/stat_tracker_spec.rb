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

  describe 'most_accurate_team' do
    it 'returns most accurate team for each season as a string' do

    expect(@stat_tracker.most_accurate_team["20122013"]).to eq("FC Dallas")
    end
  end

  describe 'least_accurate_team' do
    it 'returns least accurate team for each season as a string' do

    expect(@stat_tracker.least_accurate_team["20122013"]).to eq("New York City FC")
    end
  end

  describe 'most_tackles' do
    it 'returns teams with most stackles as a string' do

    expect(@stat_tracker.most_tackles["20122013"]).to eq("FC Cincinnati")
    end
  end

  describe 'fewest_tackles' do
    it 'returns teams with fewest tackles as a string' do

    expect(@stat_tracker.fewest_tackles["20122013"]).to eq("Atlanta United")
    end
  end




end
