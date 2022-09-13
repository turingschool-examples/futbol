# require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end
  
  it '#total_games' do
    expect(@stat_tracker.total_games).to eq(7441)
  end

  it '#total_home_wins' do 
    expect(@stat_tracker.total_home_wins).to be(4754)
    require 'pry'; binding.pry
  end


end
