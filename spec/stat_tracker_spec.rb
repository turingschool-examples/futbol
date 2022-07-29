require './lib/stat_tracker'

RSpec.describe StatTracker do

  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '1. exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '3. can load an array of multiple CSVs' do
    expect(@stat_tracker.games).to be_a(CSV::Table)
    expect(@stat_tracker.teams).to be_a(CSV::Table)
    expect(@stat_tracker.game_teams).to be_a(CSV::Table)
  end

  it "A hash with key/value pairs for the following attributes" do
    expected = {
      "team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => "/api/v1/teams/1"
      }

    expect(@stat_tracker.team_info("1")).to eq(expected)
  end

  it "seasons with highest win percentange for team" do

    expect(@stat_tracker.best_season("16")).to eq("1.8")
  end

  it "seasons with lowest win percentage for team" do


    expect(@stat_tracker.worst_season("16")).to eq("0.6")
  end

  it "average win percentage of all games for a team" do

    expect(@stat_tracker.average_win_percentage("16")).to eq("")

  end

end
