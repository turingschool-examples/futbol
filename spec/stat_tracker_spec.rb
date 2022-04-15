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
end
