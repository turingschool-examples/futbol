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
    # tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')
    
    # binding.pry
    expect(@stat_tracker.total_games).to eq 7441
  #  binding.pry
  end

  # it '#percentage_ties' do
  #   tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

  #   expect(tracker.percentage_ties).to eq .20
  # end


  # it "#percentage_home_wins" do
  #   tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

  #   expect(tracker.percentage_home_wins).to eq .44
  # end
end