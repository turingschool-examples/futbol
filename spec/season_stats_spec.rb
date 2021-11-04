require './lib/stat_tracker'
require './lib/league_stats'
require './lib/season_stats'
require 'simplecov'
require 'csv'

RSpec.describe SeasonStats do
  before :each do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      games_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    season_obj = SeasonStats.new(@stat_tracker)
    expect(season_obj).to be_instance_of(SeasonStats)
  end
end 
