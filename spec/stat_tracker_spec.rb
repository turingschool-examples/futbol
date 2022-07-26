require './lib/stat_tracker'

RSpec.describe StatTracker do

  it '1. exists' do
    team_path = './data/teams.csv'
    location = team_path
    stat_tracker = StatTracker.new(location)

    expect(stat_tracker).to be_an_instance_of StatTracker
  end

  it '2. can load filepath' do
    team_path = './data/teams.csv'
    location = team_path
    stat_tracker = StatTracker.new(location)
    # require "pry"; binding.pry
    expect(stat_tracker.data.headers).to eq [:team_id,:franchiseid,:teamname,:abbreviation,:stadium,:link]
  end

  it '3. can load an array of multiple CSVs' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    
    expect(stat_tracker).to be_a Hash
    expect(stat_tracker.keys).to eq([:games, :teams, :game_teams])
    expect(stat_tracker.values).to all be_an_instance_of StatTracker
  end
end
