require 'spec_helper'

RSpec.describe StatTracker do
  it "exists" do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_a(StatTracker)
  end

  it "has attributes" do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.games).to eq(locations[:games])
    expect(stat_tracker.teams).to eq(locations[:teams])
    expect(stat_tracker.game_teams).to eq(locations[:game_teams])
  end
end
