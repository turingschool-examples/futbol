require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    games_file = './data/games_dummy.csv'
    teams_file = './data/teams.csv'
    game_teams_file = './data/game_teams_dummy.csv'

    locations = {
      games: games_file,
      teams: teams_file,
      game_teams: game_teams_file
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  xit 'exists' do
    expect(@stat_tracker).to be_a StatTracker
  end

  xit 'initializes data from a CSV file' do
    expect(@stat_tracker.games.first).to be_a Game
    expect(@stat_tracker.teams.first).to be_a Team
    expect(@stat_tracker.game_teams.first).to be_a GameTeam
  end

  it 'has the team by id' do
    expect(@stat_tracker.find_team_name_by_id(6)).to be "FC Dallas"
  end
end