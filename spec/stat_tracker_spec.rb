require "rspec"
require './lib/stat_tracker'
require "./lib/team"

RSpec.describe StatTracker do
  let(:stat_tracker) {StatTracker.new}

  it "1. exists" do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it "2. has readable attributes" do
    expect(stat_tracker.teams_reader).to eq(nil)
    expect(stat_tracker.games_reader).to eq(nil)
    expect(stat_tracker.game_teams_reader).to eq(nil)
  end

  it "3. can parse CSV data" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games.csv',
                      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.teams_reader[0][:team_id]).to eq("1")
    expect(stat_tracker.teams_reader[0][:franchiseid]).to eq("23")
    expect(stat_tracker.teams_reader[4][:link]).to eq("/api/v1/teams/6")
  end

  it "4. #count_of_teams" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
    games: './data/games_dummy_2.csv',
    game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.count_of_teams).to eq(5)
  end

  it "#. calculates without duplicates total goals in a game across all games" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.unique_total_goals).to be_a(Array)
    #we'll test the third element, which should have 1 home goal and 2 away goals
    expect(stat_tracker.unique_total_goals[2]).to eq(4)
    expect(stat_tracker.unique_total_goals.length).to eq(4)
  end



  it "#. highest_total_score" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker= StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it "#. lowest_total_score" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.lowest_total_score).to eq(1)
  end

  it "#. total_number_of_games" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.total_number_of_games).to eq(10)
  end

  it "#. percentage_home_wins" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_home_wins).to eq(30.00)
  end

  it "#. percentage_visitor_wins" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_visitor_wins).to eq(20.00)
  end

  it "#. percentage_ties" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_ties).to eq(10.00)
  end

  it "#. team_finder" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.team_finder("4")).to eq(stat_tracker.teams_reader[1])
    expect(stat_tracker.team_finder("6")).to eq(stat_tracker.teams_reader[4])
    expect(stat_tracker.team_finder("4")[0]).to eq("4")
  end

  it "#. team_info" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.team_info("1")).to eq({team_id: "1",
                                                   franchise_id: "23",
                                                   team_name: "Atlanta United",
                                                   abbreviation: "ATL",
                                                   link: "/api/v1/teams/1"
    })
  end

  it "#. average_win_percentage" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.average_win_percentage("6")).to eq(100.00)
  end

  it "#. count_of_games_by_season" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.count_of_games_by_season).to eq({"20112012" => 2, "20122013" => 6, "20132014" => 2})
  end

  it "#. most_goals_scored" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.most_goals_scored("3")).to eq(2)
  end

  it "#. fewest_goals_scored" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.fewest_goals_scored("6")).to eq(2)
  end
end
