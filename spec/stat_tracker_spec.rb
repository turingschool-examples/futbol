require "./lib/stat_tracker.rb"
require "./lib/teams.rb"
require "./lib/game"
require "./lib/game_teams"

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


  it 'can name the coach with the best winning percentage' do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    expect(@stat_tracker.winningest_coach("20142015")).to eq("Alain Vigneault")
  end

  it 'can name the coach with the worst winnig percentage' do
    expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  xit 'can name the team with the best shot accuracy' do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  xit 'can name the team with the worst shot accuracy' do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  xit 'can name the team with the most tackles made' do
    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  xit 'can name the team with the least tackles made' do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

  it 'can create a hash with team_id, franchise_id, team_name, abbreviation, and link ' do
    expect(@stat_tracker.team_info("18")).to eq({
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18",
    })
  end


  it 'can tell the most goals a team has scored in a game across all seasons' do
    expect(@stat_tracker.most_goals_scored("18")).to eq(7)
  end

  it 'can tell the fewest goals a team has scored in a game across all seasons' do
   expect(@stat_tracker.fewest_goals_scored("18")).to eq(0)
  end

  it 'can isolate a single teams games in game_teams' do #game_teams helper
    expect(@stat_tracker.team_isolator("6")).to be_an(Array)
  end

  it 'can isolate a single teams wins in game_teams' do #game_teams helper
    expect(@stat_tracker.win_isolator("6")).to be_an(Array)
  end

  it 'can group games by season in games' do #game helper
    expect(@stat_tracker.season_grouper).to be_a(Hash)
  end

  it 'can isolate a single teams games in games' do #game helper
    expect(@stat_tracker.all_team_games("6")).to be_an(Array)
  end

  it 'can isolate a teams games by season in games' do #game helper
    expect(@stat_tracker.season("6", "20122013")).to be_an(Array)
  end

  it 'can find a teams average win percentage' do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  it 'can group a teams games by season in games' do

    expect(@stat_tracker.team_season_game_counter("6")).to be_a(Hash)
  end

  xit 'can tell which season is a teams best' do
    expect(@stat_tracker.best_season("6")).to eq("20132014")
   end

  it "can count the total number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "gives a hash of team id to team name" do
    expect(@stat_tracker.team_id_to_name.length).to eq(32)
    expect(@stat_tracker.team_id_to_name).to be_a(Hash)
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

  it "can calculate which team was the highest scoring home team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it "it can calculate which team was the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it "it can calculate which team was the lowest scoring home team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  it "can find favorite opponent for a given team" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "can find rival for a given team" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end
end
