require "./game_teams_stats"
require "./game"
require "./game_teams"
require "./teams"
require "csv"
require "./isolatable"
require "./averageable"

describe GameTeamsStats do
  before :each do
    game_teams_path = "./data/game_teams.csv"
    @game_teams_stats = GameTeamsStats.from_csv(game_teams_path)
    @game_teams_stats.extend(Averageable)
    @game_teams_stats.extend(Isolatable)
  end

  it "exists" do
    expect(@game_teams_stats).to be_a(GameTeamsStats)
  end

  it "can tell the most goals a team has scored in a game across all seasons" do
    expect(@game_teams_stats.most_goals_scored("18")).to eq(7)
  end

  it "can tell the fewest goals a team has scored in a game across all seasons" do
    expect(@game_teams_stats.fewest_goals_scored("18")).to eq(0)
  end

  it "can calculate which team had the best offense" do
    expect(@game_teams_stats.best_offense.size).to eq 32
  end

  it "can calculate which team had the worst offense" do
    expect(@game_teams_stats.worst_offense.size).to eq 32
    expect(@game_teams_stats.worst_offense[0][0].to_i).to eq 3
  end

  it "can isolate coach wins" do
    game_id_list = ["2013030161",
                    "2013030162",
                    "2013030163",
                    "2013030164",
                    "2013030165",
                    "2013030166",
                    "2013030151",
                    "2013030152",
                    "2013030153",
                    "2013030154",
                    "2013030155"]
    expect(@game_teams_stats.isolate_coach_wins(game_id_list).length).to eq(4)
    expect(@game_teams_stats.isolate_coach_wins(game_id_list).keys[0]).to eq("Joel Quenneville")
    expect(@game_teams_stats.isolate_coach_wins(game_id_list)).to be_a(Hash)
  end

  it "can calculate game percentage won for a coach" do
    game_id_list = ["2013030161",
                    "2013030162",
                    "2013030163",
                    "2013030164",
                    "2013030165",
                    "2013030166",
                    "2013030151",
                    "2013030152",
                    "2013030153",
                    "2013030154",
                    "2013030155"]
    coaches =
      { "Ken Hitchcock" => 28,
        "Joel Quenneville" => 30,
        "Mike Yeo" => 35,
        "Patrick Roy" => 33,
        "Bruce Boudreau" => 26,
        "Darryl Sutter" => 35,
        "Lindy Ruff" => 36,
        "Craig Berube" => 31,
        "Mike Babcock" => 31,
        "Dan Bylsma" => 34,
        "Jack Capuano" => 34 }
    expect(@game_teams_stats.coach_percentage_won(coaches, game_id_list)).to be_a(Hash)
    expect(@game_teams_stats.coach_percentage_won(coaches, game_id_list).length).to eq(4)
    expect(@game_teams_stats.coach_percentage_won(coaches, game_id_list).keys[0]).to eq("Joel Quenneville")
  end

  it "can isolate coach losses" do
    game_id_list = ["2013030161",
                    "2013030162",
                    "2013030163",
                    "2013030164",
                    "2013030165",
                    "2013030166",
                    "2013030151",
                    "2013030152",
                    "2013030153",
                    "2013030154",
                    "2013030155"]
    expect(@game_teams_stats.isolate_coach_loss(game_id_list).length).to eq(4)
    expect(@game_teams_stats.isolate_coach_loss(game_id_list).keys[0]).to eq("Ken Hitchcock")
    expect(@game_teams_stats.isolate_coach_loss(game_id_list)).to be_a(Hash)
  end

  it "can calculate game percentage lost for a coach" do
    game_id_list = ["2013030161",
                    "2013030162",
                    "2013030163",
                    "2013030164",
                    "2013030165",
                    "2013030166",
                    "2013030151",
                    "2013030152",
                    "2013030153",
                    "2013030154",
                    "2013030155"]
    coaches =
      { "Ken Hitchcock" => 28,
        "Joel Quenneville" => 30,
        "Mike Yeo" => 35,
        "Patrick Roy" => 33,
        "Bruce Boudreau" => 26,
        "Darryl Sutter" => 35,
        "Lindy Ruff" => 36,
        "Craig Berube" => 31,
        "Mike Babcock" => 31,
        "Dan Bylsma" => 34,
        "Jack Capuano" => 34 }
    expect(@game_teams_stats.coach_percentage_loss(coaches, game_id_list)).to be_a(Hash)
    expect(@game_teams_stats.coach_percentage_loss(coaches, game_id_list).length).to eq(4)
    expect(@game_teams_stats.coach_percentage_loss(coaches, game_id_list).keys[0]).to eq("Ken Hitchcock")
  end

  it "can find number of tackles given a team id and game id" do
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"

    @game_teams_stats_dummy = GameTeamsStats.from_csv(game_teams_path)
    @game_teams_stats_dummy.extend(Averageable)
    expect(@game_teams_stats_dummy.number_of_tackles("3", "2012030221")).to eq(44)
  end

  it 'can find the results for all game ids' do 
    expect(@game_teams_stats.all_game_results("3")).to be_a(Hash)
    expect(@game_teams_stats.all_game_results("18").length).to eq((@game_teams_stats.game_teams.length)/2)
    expect(@game_teams_stats.all_game_results("1").length).to eq((@game_teams_stats.game_teams.length)/2)
  end

  it 'can find all teams overall records against a given team' do
    expect(@game_teams_stats.record_vs_our_team("18")).to be_a(Hash)
    expect(@game_teams_stats.record_vs_our_team("18").length).to eq(31)
    expect(@game_teams_stats.record_vs_our_team("1").length).to eq(31)
  end

  it 'can find the team id of the team with the worst overall record against a given team' do
    expect(@game_teams_stats.min_win_percent("1")).to be_a(Array)
    expect(@game_teams_stats.min_win_percent("18")[0]).to eq("14")
    expect(@game_teams_stats.min_win_percent("1")[0]).to eq("25")
  end

  it 'can find the team id of the team with the best overall record against a given team' do
    expect(@game_teams_stats.max_win_percent("1")).to be_a(Array)
    expect(@game_teams_stats.max_win_percent("18")[0]).to eq("14").or eq("17")
    expect(@game_teams_stats.max_win_percent("1")[0]).to eq("17")
  end
end