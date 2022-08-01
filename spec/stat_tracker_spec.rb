require "./lib/stat_tracker.rb"
require "./lib/teams.rb"
require "./lib/game"
require "./lib/game_teams"
require "./lib/helpable"

describe StatTracker do
  before :each do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @stat_tracker.extend(Helpable)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it "has games" do
    stat_tracker = StatTracker.new(
      [{ game_id: "2012030221",
         season: "20122013",
         type: "Postseason",
         date_time: "5/16/13",
         away_team_id: "3",
         home_team_id: "6",
         away_goals: "2",
         home_goals: "3",
         venue: "Toyota Stadium",
         venue_link: "/api/v1/venues/null" }],
      # Games
      [{ team_id: "1",
         franchiseId: "23",
         teamName: "Atlanta United",
         abbreviation: "ATL",
         Stadium: "Mercedes-Benz Stadium",
         link: "/api/v1/teams/1" }],
      # Teams
      [{ game_id: "2012030221",
         team_id: "3",
         HoA: "away",
         result: "LOSS",
         settled_in: "OT",
         head_coach: "John Tortorella",
         goals: "2",
         shots: "8",
         tackles: "44",
         pim: "8",
         powerPlayOpportunities: "3",
         powerPlayGoals: "0",
         faceOffWinPercentage: "44.8",
         giveaways: "17",
         takeaways: "7" }]
      # Game Teams
    )
    expect(stat_tracker.games.length).to eq(1)
    expect(stat_tracker.teams.length).to eq(1)
    expect(stat_tracker.game_teams.length).to eq(1)
  end

  it "has the right class when reading from csv" do
    expect(@stat_tracker).to be_a(StatTracker)
    expect(@stat_tracker.games).to be_a(Array)
    expect(@stat_tracker.teams).to be_a(Array)
    expect(@stat_tracker.game_teams).to be_a(Array)
  end

  it "is reading the full csv file" do
    expect(@stat_tracker.games.length).to eq(7441)
    expect(@stat_tracker.teams.length).to eq(32)
    expect(@stat_tracker.game_teams.length).to eq(14882)
  end

  it "can calculate the games highest total score" do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it "can calculate the games lowest total score" do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it "can calculate the games precentage home wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(0.44)
  end

  it "can calculate the games percentage visitor wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
  end

  it "can calculate the games percentage ties" do
    expect(@stat_tracker.percentage_ties).to eq(0.20)
  end

  it "can calculate the games count of games by season" do
    expected = {
      "20122013" => 806,
      "20162017" => 1317,
      "20142015" => 1319,
      "20152016" => 1321,
      "20132014" => 1323,
      "20172018" => 1355,
    }

    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
  end

  it "can calculate the games count of games by season for different data" do
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expected = { "20122013" => 9 }

    expect(@stat_tracker_dummy.count_of_games_by_season).to eq(expected)
  end

  it "can calculate the games average goals per game" do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
  end

  it "can calculate the games average goals by season" do
    expected = {
      "20122013" => 4.12,
      "20162017" => 4.23,
      "20142015" => 4.14,
      "20152016" => 4.16,
      "20132014" => 4.19,
      "20172018" => 4.44,
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  it "can calculate the games average goals by season for dummy data" do
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expected = { "20122013" => 3.78 }

    expect(@stat_tracker_dummy.average_goals_by_season).to eq(expected)
  end

  it "can count the total number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "can calculate which team was the highest scoring home team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it "can calculate the lowest average of an array in an array of team_id, average" do #helper method
    average = [["3", 2.1], ["6", 2.28], ["16", 2.23], ["5", 2.39], ["8", 2.08]]
    expect(@stat_tracker.minimum(average)).to eq(["8", 2.08])
  end

  it "can calculate the highest average of an array in an array of team_id, average" do #helper method
    average = [["3", 2.1], ["6", 2.28], ["16", 2.23], ["5", 2.39], ["8", 2.08]]
    expect(@stat_tracker.maximum(average)).to eq(["5", 2.39])
  end

  it "can name the coach with the best winning percentage" do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    expect(@stat_tracker.winningest_coach("20142015")).to eq("Alain Vigneault")
  end

  it "can name the coach with the worst winning percentage" do
    expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "can identify all games that correspond to a certain season id" do #helper method
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expected = ["2012030221",
               "2012030222",
               "2012030223",
               "2012030224",
               "2012030225",
               "2012030311",
               "2012030312",
               "2012030313",
               "2012030314"]
    expect(@stat_tracker_dummy.games_by_season("20122013")).to eq(expected)
  end

  it "can name the team with the best shot accuracy" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "can name the team with the worst shot accuracy" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "can create a hash with team_id, franchise_id, team_name, abbreviation, and link " do
    expect(@stat_tracker.team_info("18")).to eq({
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18",
    })
  end

  it "can tell the most goals a team has scored in a game across all seasons" do
    expect(@stat_tracker.most_goals_scored("18")).to eq(7)
  end

  it "can tell the fewest goals a team has scored in a game across all seasons" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq(0)
  end

  it "can isolate a single teams games in game_teams" do #game_teams helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.team_isolator("6").map {|game| game.game_id}).to eq(["2012030221", "2012030222", "2012030223", "2012030224"])
    expect(@stat_tracker_dummy.team_isolator("6").size).to eq(4)
    expect(@stat_tracker_dummy.team_isolator("6")).to be_an(Array)
  end

  it "can isolate a single teams wins in game_teams" do #game_teams helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.win_isolator("6")).to be_an(Array)
    expect(@stat_tracker_dummy.win_isolator("6").size).to eq(4)
    expect(@stat_tracker_dummy.win_isolator("6").map {|game| game.game_id}).to eq(["2012030221", "2012030222", "2012030223", "2012030224"])
  end

  it "can group games by season in games" do #game helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    values_array = ["2012030221",
                     "2012030222",
                     "2012030223",
                     "2012030224",
                     "2012030225",
                     "2012030311",
                     "2012030312",
                     "2012030313",
                     "2012030314"]

    expect(@stat_tracker_dummy.season_grouper.keys).to eq(["20122013"])
    expect(@stat_tracker_dummy.season_grouper.values[0].map {|game| game.game_id}).to eq(values_array)
    expect(@stat_tracker_dummy.season_grouper).to be_a(Hash)
  end

  it "can isolate a single teams games in games" do #game helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.all_team_games("3")).to be_an(Array)
    expect(@stat_tracker_dummy.all_team_games("3").map {|game| game.game_id}).to eq(["2012030221",
                                                                                     "2012030222",
                                                                                     "2012030223",
                                                                                     "2012030224",
                                                                                     "2012030225"])
  end

  it "can isolate a teams games by season in games" do #game helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.get_teamgames_by_single_season("6", "20122013")).to be_an(Array)
    expect(@stat_tracker_dummy.get_teamgames_by_single_season("6", "20122013").map {|game| game.date_time}).to eq(["5/16/13",
                                                                                           "5/19/13",
                                                                                           "5/21/13",
                                                                                           "5/23/13",
                                                                                           "5/25/13",
                                                                                           "6/2/13",
                                                                                           "6/4/13",
                                                                                           "6/6/13",
                                                                                           "6/8/13"])
  end

  it "can find a teams average win percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  it "can group a teams games by season in games" do #helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker.team_season_grouper("6")).to be_a(Hash)
    expect(@stat_tracker.team_season_grouper("6").keys).to eq(["20122013", "20172018", "20132014", "20142015", "20152016", "20162017"])
  end

  it "can tell which season is a teams best" do
    expect(@stat_tracker.best_season("6")).to eq("20132014")
   end

  it "can count the total number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "can tell which season is a teams worst" do
    expect(@stat_tracker.worst_season("6")).to eq("20142015")
  end

  it "gives a hash of team id to team name" do #team_id_to_name helper
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.team_id_to_name.length).to eq(9)
    expect(@stat_tracker_dummy.team_id_to_name).to be_a(Hash)
    expect(@stat_tracker_dummy.team_id_to_name.keys).to eq(["1", "4", "26", "14", "6", "3", "5", "17", "28"])
    expect(@stat_tracker_dummy.team_id_to_name.values).to eq(["Atlanta United",
                                                               "Chicago Fire",
                                                               "FC Cincinnati",
                                                               "DC United",
                                                               "FC Dallas",
                                                               "Houston Dynamo",
                                                               "Sporting Kansas City",
                                                               "LA Galaxy",
                                                               "Los Angeles FC"])
  end

  it "can calculate which team had the best offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  it "can calculate which team had the worst offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it "can calculate which team was the highest scoring visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  it "can calculate which team was the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it "can calculate which team was the lowest scoring home team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  it "can calculate which team has the most tackles in the season" do
    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "can calculate which team has the fewest tackles in the season" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

  it "can find favorite opponent for a given team" do
    expect(@stat_tracker.favorite_opponent("18")).to eq("DC United")
  end

  it "can find number of tackles given a team id and game id" do
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.number_of_tackles("3", "2012030221")).to eq(44)
  end

  it "can get a ratio of goals to shots when given a season id number" do
    game_path = "./spec/fixtures/dummy_game.csv"
    team_path = "./spec/fixtures/dummy_teams.csv"
    game_teams_path = "./spec/fixtures/dummy_game_teams.csv"
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    @stat_tracker_dummy = StatTracker.from_csv(locations)
    @stat_tracker_dummy.extend(Helpable)
    expect(@stat_tracker_dummy.get_ratio("20122013")).to eq({"3"=>0.21052631578947367, "6"=>0.2894736842105263})
  end

  it "can find rival for a given team" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end

end
