require 'rspec'
require './lib/stat_tracker'
require './lib/team'
require './lib/game'
require './lib/team_statistics'

RSpec.describe TeamStatTracker do
  dummy_filepath = {teams: "./data/teams.csv",
                    games: './data/games_dummy_final.csv',
                    game_teams: './data/game_teams_dummy_final.csv'

  }
  let(:team_1_stat_tracker) {TeamStatTracker.from_csv(dummy_filepath)}

  it "1. exists" do
    expect(team_1_stat_tracker).to be_a(TeamStatTracker)
  end

  it "2. has readable hash attribute 'team_games' that is empty by default" do
    expect(team_1_stat_tracker.team_games).to eq({})
  end

  it "3. imports all games for a team into 'team_games'" do
    team_1_stat_tracker.team_games_import("3")
    expect(team_1_stat_tracker.team_games).to be_a(Hash)
    expect(team_1_stat_tracker.team_games[:"2012030221"]).to be_a(Game)
    expect(team_1_stat_tracker.team_games.keys).to eq([:"2012030221", :"2012030222", :"2012030223", :"2012030224", :"2012030225"])
  end

  it "4. can determine best season for a team" do
    team_1_stat_tracker.team_games_import("6")
    expect(team_1_stat_tracker.best_season("6")).to eq("20122013")
  end

  it "5. can determine best season for a team" do
    team_1_stat_tracker.team_games_import("3")
    expect(team_1_stat_tracker.worst_season("3")).to eq("20122013")
  end

  it "6. can calculate average win percentage" do
    team_1_stat_tracker.team_games_import("17")
    expect(team_1_stat_tracker.average_win_percentage("17")).to eq(0.5)
  end

  it "7. can calculate the most goals scored for a team" do
    team_1_stat_tracker.team_games_import("3")
    expect(team_1_stat_tracker.most_goals_scored("3")).to eq(2)
  end

  it "8. can calculate the least goals scored for a team" do
    team_1_stat_tracker.team_games_import("3")
    expect(team_1_stat_tracker.fewest_goals_scored("3")).to eq(1)
  end

  it "9. can list team info" do
    team_1_stat_tracker.team_games_import("1")
    expect(team_1_stat_tracker.team_info("1")).to eq({"team_id" => "1",
    "franchise_id" => "23",
    "team_name" => "Atlanta United",
    "abbreviation" => "ATL",
    "link" => "/api/v1/teams/1"
    })
  end

  it "10. can determine favorite opponent" do
    team_1_stat_tracker.team_games_import("6")
    expect(team_1_stat_tracker.favorite_opponent("6")).to eq("Houston Dynamo")
  end

  it "11. can determine rival" do
    team_1_stat_tracker.team_games_import("3")
    expect(team_1_stat_tracker.rival("3")).to eq("FC Dallas")
  end
end