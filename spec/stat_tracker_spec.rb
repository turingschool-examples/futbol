require './lib/stat_tracker'
require 'csv'

RSpec.describe StatTracker do



  it 'exists' do
    game_path = './data/games_15_rows.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.new(locations)
    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end

  it 'has readable attributes' do
    game_path = './data/games_15_rows.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expected = CSV.read "#{locations[:games]}", headers: true, header_converters: :symbol
    expect(stat_tracker.games).to eq(expected)
  end

  it 'can give me the highest_total_score' do
    game_path = './data/games_15_rows.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.highest_total_score).to eq(7)
  end

end
