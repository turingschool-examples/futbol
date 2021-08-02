require 'spec_helper'


RSpec.describe StatTracker do
  before(:each) do

    game_path = './data/season_game_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/season_game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it 'has a game manager' do
    expect(@stat_tracker.game_manager).to be_a(GameManager)
  end

  it 'has a team manager' do
    expect(@stat_tracker.team_manager).to be_a(TeamManager)
  end

  it 'has a game team manager' do
    expect(@stat_tracker.game_team_manager).to be_a(GameTeamManager)
  end

  it 'has a season manager' do
    expect(@stat_tracker.season_manager).to be_a(SeasonManager)
  end

  it 'has winningest coach by season' do
    expect(@stat_tracker.winningest_coach('20122013')).to eq("Claude Julien")
  end

  it 'has worst coach by season' do
    expect(@stat_tracker.worst_coach('20122013')).to eq("John Tortorella")
  end

  it 'has most accurate team id' do
    expect(@stat_tracker.most_accurate_team('20122013')).to eq('FC Dallas')
  end

  it 'has least accurate team_id' do
    expect(@stat_tracker.least_accurate_team('20122013')).to eq('Sporting Kansas City')
  end

  it 'has team with most tackles' do
    expect(@stat_tracker.most_tackles('20122013')).to eq('FC Dallas')
  end

  it 'has team with least tackles' do
    expect(@stat_tracker.fewest_tackles('20122013')).to eq('New England Revolution')
  end

  it "counts number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "returns the name of the team with the highest avg goals per game" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "returns the name of the team with the highest avg goals per game" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "returns the name of the team with the lowest avg goals per game" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "text" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("6")
  end

  it "text" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("6")
  end

  it "text" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("5")
  end

  it "text" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("5")
  end
end




# xit "counts teams" do
#   expect(@stat_tracker.count_of_teams).to eq(32)
# end
#
# xit "calculates team with highest avg. goals/game all seasons" do
#
#
# end

# best_offense	Name of the team with the highest average number of goals scored per game across all seasons.	String
# worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
