require "simplecov"
SimpleCov.start

require "./lib/stat_tracker"
require "./lib/game"
require "./lib/team"
require "csv"


RSpec.describe StatTracker do
  before do
    game_path = './data/games_sampl.csv'
    teams_path = './data/teams_sampl.csv'
    game_teams_path = './data/game_teams_sampl.csv'
    @stat_tracker_1 = StatTracker.from_csv(game_path, teams_path, game_teams_path)
  end

  it "exists" do
    expect(@stat_tracker_1).to be_a(StatTracker)
  end

  it "can calculate the highest total score of all games" do
    expect(@stat_tracker_1.highest_total_score).to eq(6)
  end

  it "can calculate the lowest total score of all games" do
    expect(@stat_tracker_1.lowest_total_score).to eq(1)
  end

  it "can calculate the home win percentage" do
    expect(@stat_tracker_1.percentage_home_wins).to eq(0.54)
  end

  it "can calculate the visitor win percentage" do
    expect(@stat_tracker_1.percentage_visitor_wins).to eq(0.38)
  end

  it "can calculate the pecentage of games that end up in a tie" do
    expect(@stat_tracker_1.percentage_ties).to eq(0.08)
  end

  it "can count games in each season" do
    expect(@stat_tracker_1.count_of_games_by_season).to eq({"20122013"=>11, "20132014"=>2})
  end

  #may have misunderstood wording in instructions-- may need to refactor average goals methods after checking against spec harness (remove goals_averaged per game, use total goals instead)
  it "can count average goals per game" do
    expect(@stat_tracker_1.average_goals_per_game).to eq(2.04)
  end

  it "can count average goals by season" do
    expect(@stat_tracker_1.average_goals_by_season).to eq({"20122013"=>2.05, "20132014"=>2.0})
  end

  it "can count all teams" do
    #count_of_teams
    
  end


  #best_offense
  #worst_offense
  #highest_scoring_visitor
  #highest_scoring_home_team
  #lowest_scoring_visitor
  #lowest_scoring_home_team
  #winningest_coach
  #worst_coach
  #most_accurate_team
  #least_accurate_team
  #most_tackles
  #fewest_tackles
end