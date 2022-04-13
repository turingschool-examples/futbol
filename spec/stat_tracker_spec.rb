require 'simplecov'
SimpleCov.start

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

  xit 'can give me the winningest coach given a specific season' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.winningest_coach(20132014)).to eq("Claude Julien")

  end

  it 'gives me all the games given the season' do

    game_path = './data/games_15_rows.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.games_by_season(20172018).count).to eq(6)

  end

end
