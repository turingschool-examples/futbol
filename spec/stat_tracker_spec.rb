require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
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
  end

  it "exists" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker).to be_a(StatTracker)
  end

  it "has readable attributes" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker.games).to eq('file_games')
    expect(tracker.teams).to eq('file_teams')
    expect(tracker.game_teams).to eq('file_game_teams')
  end

  it "has a total number of games played" do
   
    expect(@stat_tracker.total_games).to eq 7441
  end

  it "#percentage_ties" do

    expect(@stat_tracker.percentage_ties).to eq 0.20
  end


  it "#percentage_home_wins" do

    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do

    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end
end