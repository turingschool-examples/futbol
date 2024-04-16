require 'spec_helper.rb'

RSpec.describe Game do
  it "can initialize" do
    @game_path = './data/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_fixture.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)

    expect(@stat_tracker).to be_a StatTracker
    expect(@stat_tracker.games).to be_a Array
    expect(@stat_tracker.teams).to be_a Array
    expect(@stat_tracker.game_teams).to be_a Array
  end
end