require 'simplecov'
SimpleCov.start
#
# require_relative 'game'
# require_relative 'team'
# require_relative 'game_team'

require './lib/stat_tracker'
require './lib/game_team'
require './lib/team'
require './lib/game'
require 'csv'

RSpec.describe StatTracker do
  before(:all) do
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

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  it 'has readable attributes' do
    expect(@stat_tracker.teams.count).to eq(32)
  end

  it 'can give us team info' do

   expected = {:team_id=>1,
               :franchise_id=>23,
               :team_name=>"Atlanta United",
               :abbreviation=>"ATL",
               :link=>"/api/v1/teams/1"}

   expect(@stat_tracker.team_info(1)).to eq(expected)
 end

  it 'can give me the highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it 'can calculate lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it 'can calculate percentage_home_wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(0.44)
  end

  it 'can calculate percentage_visitor_wins' do
    expect(@stat_tracker.percentage_away_wins).to eq(0.36)
  end

  it 'can calculate percentage_ties' do
    expect(@stat_tracker.percentage_ties).to eq(0.20)
  end

  it 'can calculate average_goals_by_season' do

    expected = {
    "20122013"=>4.12,
    "20162017"=>4.23,
    "20142015"=>4.14,
    "20152016"=>4.16,
    "20132014"=>4.19,
    "20172018"=>4.44
  }
    expect(@stat_tracker.average_goals_by_season).to eq(expected)
  end

  it 'counts games by season' do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_games_by_season).to eq(expected)
  end

  it 'calculates average goals per game' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
  end

  it 'can give me the winningest coach given a specific season' do
    expect(@stat_tracker.winningest_coach(20132014)).to eq("Claude Julien")
  end

  it 'gives me all the games given the season' do
    expect(@stat_tracker.games_by_season(20172018).count).to eq(1355)
  end

  it 'gives me all the game teams given the season' do
    expect(@stat_tracker.game_teams_by_season(20172018).count).to eq(2710)
  end

  it 'gives me coaches records given an array of games, not including win percentage' do
    game_teams = @stat_tracker.game_teams_by_season(20172018)
    expect(@stat_tracker.coaches_records(game_teams)["Joel Quenneville"][1]).to eq(51)
  end

  it 'gives me coaches win percentage given a coaching record hash' do
    game_teams = @stat_tracker.game_teams_by_season(20172018)
    coaching_hash = @stat_tracker.coaches_records(game_teams)
    expect(@stat_tracker.win_percentage_by_coach(coaching_hash)["Joel Quenneville"][2]).to eq(0.3780487804878049)

  end

  it 'gives me the coach with the worst record given a season' do
    expect(@stat_tracker.worst_coach(20132014)).to eq("Peter Laviolette")
  end

  it 'gives me a team name given a team ID' do
    expect(@stat_tracker.team_name(29)).to eq("Orlando Pride")

  end

  it 'gives me the team with the best shot percentage given a season' do
    expect(@stat_tracker.most_accurate_team(20172018)).to eq("Portland Timbers")
  end

  it 'gives me the team with the worst shot percentage given a season' do
    expect(@stat_tracker.least_accurate_team(20172018)).to eq("Toronto FC")
  end

  it 'gives me the team with most and least tackles' do

    expect(@stat_tracker.most_tackles(20142015)).to eq("Seattle Sounders FC")
    expect(@stat_tracker.fewest_tackles(20142015)).to eq("Orlando City SC")
  end

  it 'counts total number of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

end
