require './lib/stat_tracker'
require 'simplecov'
require 'csv'
# SimpleCov.start

RSpec.describe StatTracker do
  before(:each) do
    @new_instance = StatTracker.new
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  it 'exists' do
    # locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    stat_tracker = StatTracker.new

    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end


  it '#from_csv returns hash with all data' do


    expect(StatTracker.from_csv(@locations)).to be_a (Hash)

  end

  it '#game_data' do
    stat_tracker = StatTracker.from_csv(@locations)
    games_data = StatTracker.get_data(:games)
    teams_data = StatTracker.get_data(:teams)


    expect(stat_tracker).to be_a (Hash)
    expect(games_data).to be_a (Array)
    expect(teams_data).to be_a (Array)
  end
end
