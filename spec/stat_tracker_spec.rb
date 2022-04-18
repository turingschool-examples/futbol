require 'simplecov'
SimpleCov.start

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

  it 'gives me all the games played by a team' do
    expect(@stat_tracker.game_teams_by_team(19).count).to eq(507)
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


  it 'gives me a hash of shot percentages given a season' do
    expect(@stat_tracker.accuracy_hash(20172018)[28][2]).to eq(0.29614325068870523)
  end

  it 'gives me an array of tackles given a season' do
    expect(@stat_tracker.tackle_hash(20172018)[28]).to eq(1690)
  end


  it "gives us the most goals scored for a team " do
    expect(@stat_tracker.most_goals_scored(18)). to eq(7)
  end

  it "gives us the fewest goals scored for a team" do
    expect(@stat_tracker.fewest_goals_scored(19)).to eq(0)
  end

  it "gives us the best season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  it "gives us the worst season" do
    expect(@stat_tracker.worst_season("6")).to eq "20142015"
  end

  it "gives us the average win percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq(0.49)
  end

  it "tells us a team's favorite opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "tells us a team's rival" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))

  it 'counts total number of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "finds avg goals of team " do
    expect(@stat_tracker.avg_total_goals(19)).to eq(2.11)
  end

  it "finds the highest scoring team aka best offense" do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it "finds the lowest scoring team aka worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it "finds highest scoring visitor aka best offense when away" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "finds highest scoring home team aka best offense when home" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it "finds lowest scoring visitor aka worst offense when away" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it "finds lowest scoring home team aka worst offense when home" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end
end
