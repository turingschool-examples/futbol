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

  it 'can give us team info' do
   stat_tracker = StatTracker.new(locations)

   expected = {:team_id=>"1",
               :franchise_id=>"23",
               :team_name=>"Atlanta United",
               :abbreviation=>"ATL",
               :link=>"/api/v1/teams/1"}

   expect(stat_tracker.team_info(1)).to eq(expected)
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

  it 'can give me the winningest coach given a specific season' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

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


  it 'gives me all the game teams given the season' do

    game_path = './data/games_15_rows.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.game_teams_by_season(20172018).count).to eq(4)
  end

  it 'gives me coaches records given an array of games, not including win percentage' do

    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    game_teams = stat_tracker.game_teams_by_season(20172018)

    expect(stat_tracker.coaches_records(game_teams)["Joel Quenneville"][1]).to eq(3)

  end

  it 'gives me coaches win percentage given a coaching record hash' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    game_teams = stat_tracker.game_teams_by_season(20172018)

    coaching_hash = stat_tracker.coaches_records(game_teams)

    expect(stat_tracker.win_percentage_by_coach(coaching_hash)["Joel Quenneville"][2]).to eq(0.4)

  end

  it 'gives me the coach with the worst record given a season' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.worst_coach(20132014)).to eq("Peter Laviolette")

  end

  it 'gives me a team name given a team ID' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    id = 29

    expect(stat_tracker.team_name(id)).to eq("Orlando Pride")

  end

  it 'gives me an array of total amount of something when i pass it in' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    game_teams = stat_tracker.game_teams_by_season(20172018)
    expect(stat_tracker.total_amount(game_teams, :goals)).to eq(9)

  end

  it 'gives me the team with the best shot percentage given a season' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.most_accurate_team(20172018)).to eq("Portland Timbers")
  end

  it 'gives me the team with the worst shot percentage given a season' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.least_accurate_team(20172018)).to eq("Toronto FC")
  end

  it 'gives me the team with most and least tackles' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.most_tackles(20142015)).to eq("Seattle Sounders FC")
    expect(stat_tracker.fewest_tackles(20142015)).to eq("Orlando City SC")
  end

  it 'counts total number of teams' do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/games_teams_15_rows.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.count_of_teams).to eq(32)
  end
end
  # it " " do
  #
  # end
